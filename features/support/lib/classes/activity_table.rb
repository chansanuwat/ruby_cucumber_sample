require "#{File.dirname(__FILE__)}/../helpers/result_parsing"

class ActivityTable

  include ResultParsing

  RowValues = lambda { |row|
    cells = Finder.every({locator: 'p', el: row})
    title = Finder.text_of({locator: 'strong', el: cells[0]}).strip
    message = Finder.text_of({this_el: cells[1]}).strip
    timestamp = Finder.text_of({this_el: cells[2]}).strip
    return {"Title" => title, "Message" => message, "Timestamp" => timestamp, "Cells" => cells}
  }

  Locator = 'div.ibox-content div.timeline-item'
  
  def initialize capture = true
    @results = []
    parse if capture
  end

  def parse
    @results = parse_data(Locator, RowValues)
  end

  def find_row_with values
    return match_row(Locator, values, RowValues)
  end

end