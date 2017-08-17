module ResultParsing

  def parse_data locator, set_values, reverse = false
    results = []
    if reverse then
      rows = Finder.every({locator: locator}).to_a.reverse
    else
      rows = Finder.every({locator: locator})
    end
    rows.each do |row|
      results << set_values.call(row)
    end
    return results
  end

  def match_row locator, values, set_values, reverse = false
    if reverse then
      rows = Finder.every({locator: locator}).to_a.reverse
    else
      rows = Finder.every({locator: locator})
    end
    rows.each do |row|
      result = set_values.call(row)
      return result if match?(result, values)
    end
    return nil
  end

  def match_parsed_row results, values
    results.each do |result|
      return result if match?(result, values)
    end
    return nil
  end

  def match? result, values
    this_value = true
    values.each do |k,v|
      unless result[k].match(v) then
        this_value = false
      end
      break unless this_value
    end
    return this_value
  end

  def has_result_with? values
    return (find_row_with(values).nil? == false)
  end

  def no_result_with? values
    return (find_row_with(values).nil?)
  end

  def has_parsed_result_with? values
    return (match_parsed_row(@results, values).nil? == false)
  end

  def no_parsed_result_with? values
    return (match_parsed_row(@results, values).nil?)
  end

end