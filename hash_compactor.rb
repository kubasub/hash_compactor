module HashCompactor
  def self.compact(hash)
    hash.select do |_, value|
      if value.is_a?(Hash)
        next false if compact(value).empty?
        # BUG: this returns "true" that the whole sub-hash should be added -- not the compacted one. This is due to how select works. Try using `map`
        true
      else
        case
        when value.is_a?(NilClass)
          next false
        when value.is_a?(String)
          next false if value == ""
        when value.is_a?(Enumerable)
          next false if value.empty?
        end
        true
      end
    end
  end
end
