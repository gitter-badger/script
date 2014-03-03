#!/usr/bin/ruby -w
# map_spec.rb
# Description: One-stop-shop for geospatial orientation

require 'geocoder'

class Map
  attr_reader :current_locale

  def current
    @current_locale = Geocoder.coordinates(system('curl ifconfig.me'))
  end
  
  def ping_friends
    current
    
  end
end

describe "Map" do
  it "should return my current latitude and longitude" do
    mapper = Map.new
    locale = mapper.current
    locale.should_not be_nil 
    locale.class == Array
    locale.size == 2
    locale[0].should be_kind_of(Float)
    locale[1].should be_kind_of(Float)
  end

  it "should allow searching nearby people" do
    mapper = Map.new
    nearby = mapper.ping_friends
    nearby.should be_kind_of(Array)
    if nearby.size >= 1
      nearby.each do |friend|
        friend[:name].should_not be_nil
        friend[:name].should be_kind_of(String)
        friend[:address].should_not be_nil
        friend[:address].should be_kind_of(String)
        friend[:latitude].should_not be_nil
        friend[:latitude].should be_kind_of(Float)
        friend[:longitude].should_not be_nil
        friend[:longitude].should be_kind_of(Float)
      end
    end
  end

  it "should allow searching nearby places"
  it "should allow searching nearby things"
  it "should return distance to target locale"
  it "should return the geographic center of locale arguments"
  it "should reverse geocode target place or coordinate pair"
  it "should return coordinates of IP Address"
  it "should return coordinates of HTTP Request"
  it "should return the shortest of all given paths"
  it "should set target destination and begin alerts with bearings, distances, ETAs"
end
