require "#{File.dirname(__FILE__)}/../helpers/result_parsing"

class ConnectedFileTable

  include ResultParsing

  RowValues = lambda { |row|
    cells = Finder.every({locator:'td', el: row})
    id = Finder.value_of_attribute({attribute: 'id', this_el: row}).strip
    name = Finder.text_of({this_el: cells[0]}).strip
    uploaded_by = Finder.text_of({this_el: cells[1]}).strip
    timestamp = Finder.text_of({this_el: cells[2]}).strip
    size = Finder.text_of({this_el: cells[3]}).strip
    return {"Id" => id, "Name" => name, "Uploaded By" => uploaded_by, "Uploaded Date" => timestamp, "File Size" => size}
  }

  Locator = 'div.pd-droptarget div.table-responsive tbody tr'
  
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

  def delete match_data
    row = find_row_with(match_data)
    return nil if row.nil?
    Navigator.click_el(Finder.one({locator: "a#button_delete_#{row['Id'].split('-')[1]}"}))
    sleep 1
    Navigator.button('Yes, delete it!')
    return row
  end

end