#!/usr/bin/ruby -w
# temperature_converter.rb
# Author: Andy Bettisworth
# Description: convert temperature
# LINK http://www.gnu.org/sofware/units/units.html

class TemperatureConverter
  BASE_UNIT_OF = {
    'temperature' => 'K',
    'temp' => 'K'
  }

  C_TO_F_ADD   = 32.0
  F_TO_C_RATIO = 5.0/9.0
  C_TO_K_ADD   = 273.15

  C2K = lambda { |c| c + C_TO_K_ADD }
  F2C = lambda { |f| (f - C_TO_F_ADD ) * F_TO_C_RATIO }
  K2C = lambda { |k| k - C_TO_K_ADD }
  C2F = lambda { |c| (c / F_TO_C_RATIO) + C_TO_F_ADD }
  F2K = lambda { |f| C2K.call(F2C.call(f)) }
  K2F = lambda { |k| C2F.call(K2C.call(k)) }

  CONVERSATIONS = {
    'C' => { 'K' => C2K },
    'F' => { 'K' => F2K },
    'K' => {
      'F' => K2F,
      'C' => K2C,
    }
  }

  OUTPUT_FORMAT = "%.2f"

  def convert(params)
    conversion_proc =
    CONVERSATIONS[params[:have_unit]][params[:want_unit]] ||
    get_proc_via_base(params)

    return "#{params[:have_num]} #{params[:have_unit]} = " +
      "#{sprintf( OUTPUT_FORMAT, conversation_proc[params[:have_num]] )} " +
      "#{params[:want_unit]}"
  end

  private

  def get_proc_via_base_unit(params)
    base_unit = BASE_UNIT_OF['temperature']
    have_to_base_proc = CONVERSATIONS[params[:have_unit]][base_unit]
    base_to_want_proc = CONVERSATIONS[base_unit][params[:want_unit]]
    return lambda do |have|
      base_to_want_proc.call(have_to_base_proc.call(have))
    end
  end
end

if __FILE__ == $0
  converter = TemperatureConverter.new
end
