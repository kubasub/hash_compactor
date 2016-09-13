module HashCompactor
  def self.compact(hash)
    hash.each_with_object({}) do |(key, value), new_hash|
      value = compact(value) if value.is_a?(Hash)

      case
      when value.is_a?(NilClass)
        next
      when value.is_a?(String)
        next if value == ""
      when value.is_a?(Enumerable)
        next if value.empty?
      end

      new_hash[key] = value
    end
  end
end
