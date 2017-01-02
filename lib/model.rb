# frozen_string_literal: true

# In order to enable attributes metaprogramming we need to use Class vars here.
# rubocop:disable Style/ClassVars

class Model

  def self.property(property)
    @@properties ||= []
    @@properties << property
    attr_reader property
  end

  def self.properties
    @@properties
  end

  def initialize(attributes = {})
    @@properties.each do |property|
      instance_variable_set("@#{property}", attributes[property])
    end
    freeze
  end

  def with(attrs)
    self.class.new(self.to_h.merge(attrs))
  end

  def to_h
    @@properties.map { |attribute| [attribute, self.send(attribute)] }.to_h
  end

  def ==(other)
    other.respond_to?(:to_h) && self.to_h == other.to_h
  end
end
