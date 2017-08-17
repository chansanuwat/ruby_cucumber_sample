When(/^I add a chat message with:$/) do |text|
  Chat.input(eval(text))
  Chat.submit
end