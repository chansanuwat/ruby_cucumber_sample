require "#{File.dirname(__FILE__)}/../helpers/result_parsing"

class ChatTable

  include ResultParsing

  RowValues = lambda { |row|
    from = Finder.text_of({locator: 'chat-message-author', el: row}).strip
    message = Finder.text_of({locator: 'pre.pd-chat-pre', el: row}).strip
    timestamp = Finder.text_of({locator: 'small.text-muted', el: row}).strip
    return {"From" => from, "Message" => message, "Timestamp" => timestamp}
  }

  Locator = 'ul#chat-discussion-list li.list-group-item'
  
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