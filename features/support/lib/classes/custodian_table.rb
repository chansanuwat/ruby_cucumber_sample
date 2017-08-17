require "#{File.dirname(__FILE__)}/../helpers/result_parsing"

class CustodianTable

  include ResultParsing
  
  RowValues = lambda { |row|
    cells = Finder.every({locator: 'td', el: row})
    name = Finder.text_of({locator: 'a', el: cells[2]})
    link = Finder.one({locator: 'a', el: cells[2]})
    email = Finder.text_of({locator: 'small', el: cells[2]})
    by = Finder.text_of({this_el: cells[3]}).split(':')[1].strip.split(' ')[0].strip
    return {"Name" => name, "Email" => email, "Created by" => by, "Link" => link, "Cells" => cells}
  }

  Locator = 'div.project-list tr'

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

  def search term
    Form.input("div.pd-search-group input", term, {by: :css})
  end

  def count
    return @results.length
  end

  def delete match_data
    row = find_row_with(match_data)
    return nil if row.nil?
    Navigator.click_el(Finder.one({locator: 'a', el: row['Cells'][4]}))
    sleep 1
    Navigator.button('Yes, delete it!')
    return row
  end

end