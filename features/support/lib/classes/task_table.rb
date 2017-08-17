require "#{File.dirname(__FILE__)}/../helpers/result_parsing"

class TaskTable

  include ResultParsing

  RowValues = lambda { |row|
    hsh = Hash.new
    cells = Finder.every({locator: 'td', el: row})
    hsh['Status'] = Finder.text_of({locator: 'span', el: cells[0]}).strip
    title_el = Finder.one({locator: 'a', el: cells[1]})
    hsh['Title'] = Finder.text_of({this_el: title_el}).strip
    hsh['Description'] = Finder.text_of({locator: 'small', el: cells[1]}).strip
    hsh['Created By'] = Finder.text_of({this_el: cells[2]})
    hsh['Assigned To'] = Finder.text_of({this_el: cells[3]})
    hsh['Due'] = Finder.text_of({this_el: cells[4]})
    hsh['Completed'] = Finder.text_of({this_el: cells[5]})
    hsh['Priority'] = Finder.text_of({this_el: cells[6]})
    hsh['Link'] = title_el.path

    return hsh
  }

  Locator = 'div.panel table tbody tr'
  
  def initialize capture = true
    @results = []
    parse if capture
  end

  def parse
    @results = parse_data(Locator, RowValues, true)
  end

  def find_row_with values
    return match_row(Locator, values, RowValues, true)
  end

end