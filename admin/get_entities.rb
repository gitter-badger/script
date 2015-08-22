#!/usr/bin/ruby -w
# get_entities.rb
# Author: Andy Bettisworth
# Description: Get the entities from Rails schema.rb file

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # convert a schema.rb into respective ActiveRecord::Migrations
  class SchemaCollective
    ENTITIES_REGEXP    = Regexp.new("create_table.*?end", Regexp::IGNORECASE | Regexp::MULTILINE)
    ENTITY_NAME_REGEXP = Regexp.new('create_table\s+"(\w+)"')
    ATTRIBUTE_REGEXP   = Regexp.new('\w.*?\..*')
    ATTRIBUTE_METHOD_REGEXP   = Regexp.new('\w.*?\.(.*?)\s')
    ATTRIBUTE_NAME_REGEXP     = Regexp.new('\w.*?\.(.*?)\s.*?\b(\w.*?)\b')
    NOT_NAME_OR_VALUE_REGEXP1 = Regexp.new(':\w*?\s+=>\s+\w+?\b')
    NOT_NAME_OR_VALUE_REGEXP2 = Regexp.new('\w*?:\s+:\w+?\b')
    ALL_SYMBOLS  = Regexp.new(':(\w.*?)\b')
    INDEX_REGEXP = Regexp.new('')
    CONSTRAINT_NULL_REGEXP      = Regexp.new('null.*(false|true)')
    CONSTRAINT_DEFAULT_REGEXP   = Regexp.new(%q{default.*?["|'](.*?)["|']})
    CONSTRAINT_LIMIT_REGEXP     = Regexp.new('limit.*?(\d+)')
    CONSTRAINT_PRECISION_REGEXP = Regexp.new('precision.*?(\d+)')
    CONSTRAINT_SCALE_REGEXP     = Regexp.new('scale.*?(\d+)')

    def init
      get_schema
      parse_entities
    end

    private

    def get_schema(target_file = 'schema.rb')
      schema_path = locate_file(target_file)
      @schema_output = IO.read(schema_path)
    end

    def parse_entities
      @entities = Hash.new
      all_entities = @schema_output.scan(ENTITIES_REGEXP)
      all_entities.each do |entity|
        entity_name = entity.match(ENTITY_NAME_REGEXP)[1].to_sym
        @entities[entity_name] = {
          attributes: parse_attributes(entity),
          indexes:    parse_indexes(entity)
        }
      end
      @entities
    end

    def parse_attributes(entity)
      @attribute_array = Array.new
      all_attributes = entity.scan(ATTRIBUTE_REGEXP)
      all_attributes.each do |attribute|
        @attribute_array << create_attribute_hash(attribute)
      end
      @attribute_array
    end

    def parse_indexes(entity)
      "index"
      # index_hash = Hash.new
      # entity_hash[:indexes] = index_hash
      # all_indexes = entity.scan(INDEXES_REGEXP)
    end

    def create_attribute_hash(attribute)
      @attribute_hash = Hash.new

      get_constraints(attribute)

      if attribute.match(ATTRIBUTE_METHOD_REGEXP)[1] == "column"
        attribute_name = attribute.scan(ALL_SYMBOLS)[0][0]
        attribute_type = attribute.scan(ALL_SYMBOLS)[1][0]
      else
        attribute_type = attribute.match(ATTRIBUTE_METHOD_REGEXP)[1]
        attribute_name = attribute.match(ATTRIBUTE_NAME_REGEXP)[2]
      end

      ## HANDLE attribute appending (e.g. 't.integer :shop_id, :creator_id')
      appended_attributes = attribute.scan(ALL_SYMBOLS).flatten
      if appended_attributes.size > 1
        appended_attributes.each do |appended_attr|
          @attribute_hash = Hash.new
          @attribute_hash[:name] = appended_attr.to_sym
          @attribute_hash[:type] = attribute_type.to_sym
          @attribute_array << @attribute_hash
        end
      else
        @attribute_hash[:name] = attribute_name.to_sym
        @attribute_hash[:type] = attribute_type.to_sym
      end
      puts @attribute_hash
    end

    def get_constraints(attribute)
      constraints = Array.new
      constraints << attribute.match(CONSTRAINT_NULL_REGEXP)
      constraints << attribute.match(CONSTRAINT_DEFAULT_REGEXP)
      constraints << attribute.match(CONSTRAINT_LIMIT_REGEXP)
      constraints << attribute.match(CONSTRAINT_PRECISION_REGEXP)
      constraints << attribute.match(CONSTRAINT_SCALE_REGEXP)

      constraints.each do |constraint|
        next if constraint.nil?
        case constraint.to_s
        when /null/
          @attribute_hash[:null] = constraint[1]
        when /default/
          @attribute_hash[:default] = constraint[1]
        when /limit/
          @attribute_hash[:limit] = constraint[1].to_i
        when /precision/
          @attribute_hash[:precision] = constraint[1].to_i
        when /scale/
          @attribute_hash[:scale] = constraint[1].to_i
        end
      end

      # ! :default integers

      ## SOL: .to_i
      # ! :limit
      # ! :precision
      # ! :scale

      attribute.gsub!(NOT_NAME_OR_VALUE_REGEXP1, '')
      attribute.gsub!(NOT_NAME_OR_VALUE_REGEXP2, '')
    end

    def locate_file(target_file)
      ## Search current directory
      Dir.foreach('.') do |item|
        next if item == '.' or item == '..' or File.directory?(item)
        return File.join(File.absolute_path(recursive_dir), item) if item =~ /#{target_file}/
      end
      ## Search all subdirectories
      Dir["**/"].each do |recursive_dir|
        Dir.foreach(recursive_dir) do |item|
          next if item == '.' or item == '..' or File.directory?(item)
          return File.join(File.absolute_path(recursive_dir), item) if item =~ /#{target_file}/
        end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  collective = SchemaCollective.new
  collective.init
end
