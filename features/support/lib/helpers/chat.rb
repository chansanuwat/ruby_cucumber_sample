module Chat

  def self.input text
    Finder.one({locator: "div#chat-message-input"}).send_keys(text)
  end

  def self.submit
    Finder.one({locator: "div#chat-message-input"}).send_keys(:return)
  end

end