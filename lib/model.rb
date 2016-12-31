# frozen_string_literal: true

# In order to enable attributes metaprogramming we need to use Class vars here.
# rubocop:disable Style/ClassVars

class Model

  def self.property(property)
    @@properties ||= []
    @@properties << property
    attr_reader property
  end

  def initialize(attributes)
    @@properties.each do |property|
      instance_variable_set("@#{property}", attributes.fetch(property))
    end
    freeze
  end

  def attributes
    @@properties.map { |attribute| [attribute, self.send(attribute)] }.to_h
  end

  def ==(other)
    self.attributes == other.attributes
  end
end
