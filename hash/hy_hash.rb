require 'byebug'

class HyHash
  include Enumerable

  # Store entries in array if less than 7 entries
  # skip hasing, 'packed hashes'

  attr_reader :length, :default_value

  def initialize(default_value = nil)
    @default_value = default_value
    @length = 0

    # @table stores all entries
    @table = PackedHash.new
  end

  def [](key)
    entry = @table.find_entry(key)

    if entry
      entry.value
    else
      default_value
    end
  end

  def []=(key, value)
    if !packed_hash?
      # if entries >= 7, first convert to use hash table instead of  array
      convert_to_hash_table
    end

    entry = Entry.new(key, value)
    @table.add_entry(entry, @length + 1)
    @length += 1
  end

  def delete(key)
    @table.delete_key(key)
    @length -= 1
  end

  def each
    return to_enum(:each) if !block_given?

    @table.each do |entry|
      yield(entry.key, entry.value)
    end
  end

  def keys
    map{|k, _| k}
  end

  def values
    map{|_, v| v}
  end

  # inspect is for debugging purpose only
  def inspect
    to_s
  end

  # to is for end user or logging
  def to_s
    data = map {|k, v| "#{k} => #{v}"}.join(', ')
    "{#{data}}"
  end

  private

  # packed hashes => entries are pushed in @entries array without hashing if list is small.
  def packed_hash?
    length < PackedHash::MAX_ENTRIES
  end

  def convert_to_hash_table
    new_table = HyHashTable.new

    @table.each_with_index do |entry, index|
      new_table.add_entry(entry, index + 1)
    end

    @table = new_table
  end

  class Entry
    attr_accessor :key, :value

    def initialize(key, value)
      @key = key
      @value = value
    end

    def to_s
      "#{key} => #{value}"
    end
  end

  # If entry count is less than 7, then store in PackedHash (array) instance
  class PackedHash
    include Enumerable

    MAX_ENTRIES = 6

    def initialize
      @bins = []
    end

    def find_entry(key)
      @bins.find { |entry| entry.key == key }
    end

    def add_entry(entry, length)
      @bins.push(entry)
    end

    def each
      @bins.each
    end
  end
  # PackedHash end

  # If entry >= 7, then store in HyHashTable which is basically Array of arrays(linked list?) for now.
  class HyHashTable
    include Enumerable

    # We increase size of @bins incrementally to reduce collision (load factor or entries per bin)
    # 2**n + c
    BINS = [11, 19, 37, 67, 131]

    # Maximum number of entries per bin allowed
    MAX_DENSITY = 4

    def initialize(bins_count = BINS.first)
      # 11 empty bins
      # Warning: Array.new(11, []) => doesn't work since all 11 nested arrays refer to same array object.
      #     adding entry to any bins will add in all bins since they are basically same.
      #
      @bins = Array.new(bins_count) { [] }
    end

    def find_entry(key)
      index = get_index(key)
      @bins[index].find { |entry| entry.key == key }
    end

    def add_entry(entry, length)
      check_density(length)

      index = get_index(entry.key)
      @bins[index].push entry
    end

    def delete_key(key)
      index = get_index(key)
      @bins[index].delete_if { |entry| entry.key == key }
    end

    def each
      @bins.each do |bin|
        bin.each do |entry|
          yield(entry)
        end
      end
    end

    private

    def get_index(key)
      key.hash % @bins.length
    end

    def check_density(length)
      density = length / @bins.length
      return if density <= MAX_DENSITY

      rehash
    end

    def rehash
      new_bins = Array.new(next_bin_count) { [] }

      each do |entry|
        index = get_index(entry.key)
        new_bins[index].push entry
      end

      @bins = new_bins
    end

    def next_bin_count
      current = @bins.length
      index = BINS.find_index(current)

      BINS[index + 1]
    end
  end
  # HyHashTable end

end



def hhh
  hh = HyHash.new
  95.times.each do
    hh[rand] = rand
  end

  # hh['a'] = 1
  # hh['b'] = 9
  # hh['c'] = 'cccc'
  # hh['d'] = 81.9
  # hh['e'] = 'hello'
  # hh['f'] = -124
  # hh['g'] = 'GG'

  hh
end

hh = hhh
bins =  hh.instance_variable_get('@table').instance_variable_get('@bins').length
density = hh.length / bins
puts  ({bins: bins, entries: hh.length, density: density }).inspect
