# frozen_string_literal: true
module HashExtra

  #
  # Extract a subhash with the given keys.
  #
  #    hash = { name: "Tom", age: "51", profession: "Baker" }
  #    HashExtra.slice(hash, :name, :age)
  #    #=> { name: "Tom", age: "51" }
  #
  def self.slice(hash, *keys)
    [keys, hash.values_at(*keys)].transpose.to_h
  end

  #
  # Returns a new hash without KV pairs where the value is blank.
  # i.e. nil or empty string.
  #
  #    hash = { name: "Tom", age: " ", profession: nil }
  #    HashExtra.without_blank(hash)
  #    #=> { name: "Tom" }
  #
  def self.without_blank(hash)
    hash.clone.delete_if { |_key, value| value.to_s.strip == "" }
  end
end
