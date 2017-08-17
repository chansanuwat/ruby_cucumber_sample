Then(/^the "([^"]+)" button should be disabled$/) do |text|
  el = Finder.one({locator: "button", options: {text: text}})
  assert(el.disabled?, "Expected the '#{text}' button to be disabled")
end

Then(/^the "([^"]+)" should have a result with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  object_name = object_name.gsub(' ', '')
  assert($current[object_name].has_parsed_result_with?(table), "Expected to find a result with #{table}")
end

Then(/^parsing the "([^"]+)" should have a result with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  object_name = object_name.gsub(' ', '')
  case object_name
  when 'CustodianTable'
    Navigator.load_tab('Custodians')
  when 'ActivityTable'
    Navigator.load_tab('Activity')
  when 'ChatTable'
    # Navigator.load_tab('Chat')
    sleep 3
  when 'ConnectedFileTable'
    sleep 1
  when 'TaskTable'
    Navigator.load_tab('Tasks')
  else
    raise "Don't know how to handle #{object_name}"
  end
  $current[object_name] = Kernel.const_get(object_name).new(false) unless $current[object_name]
  assert($current[object_name].has_result_with?(table), "Expected to find a result with #{table}")
end

Then(/^the "([^"]+)" should NOT have a result with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  object_name = object_name.gsub(' ', '')
  assert($current[object_name].no_result_with?(table), "Expected NOT to find a result with #{table}")
end

Then(/^parsing the "([^"]+)" should NOT have a result with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  object_name = object_name.gsub(' ', '')
  case object_name
  when 'CustodianTable'
    Navigator.load_tab('Custodians')
  when 'ActivityTable'
    Navigator.load_tab('Activity')
  when 'ChatTable'
    # Navigator.load_tab('Chat')
    sleep 3
  when 'ConnectedFileTable'
    sleep 1
  when 'TaskTable'
    Navigator.load_tab('Tasks')
  else
    raise "Don't know how to handle #{object_name}"
  end
  $current[object_name] = Kernel.const_get(object_name).new(false) unless $current[object_name]
  assert($current[object_name].no_result_with?(table), "Expected NOT to find a result with #{table}")
end

Then(/^the "([^"]+)" should have "([^"]+)" results?$/) do |object_name, count|
  object_name = object_name.gsub(' ', '')
  actual = $current[object_name].count
  assert(actual == count.to_i, "Expected to find #{count} results, but found #{actual}")
end

Then(/^the "([^"]+)" should match:$/) do |object_name, table|
  failures = Array.new
  table = Toolbox.eval_table(table.rows_hash)
  object_name = object_name.gsub(' ', '')
  obj = Kernel.const_get(object_name).new
  table.each do |method_call, value|
    actual = obj.send(method_call)
    failures << "Detail value for #{method_call} to be #{value}, but was #{actual}" unless actual == value
  end
  assert(failures.empty?, "Got the following failures: \n\t#{failures.join("\n\t")}")
end

Then(/^there should be an error alert with:$/) do |table|
  table = Toolbox.eval_table(table.rows_hash)
  assert(has_css?('div.alert-danger', visible: true), 'Alert div was not displayed')
  alert_content = Finder.one({locator: 'div.alert-danger'})
  actual_title = Finder.text_of({locator: 'h4', el: alert_content})
  actual_message = Finder.text_of({locator: 'ul', el: alert_content})
  assert(actual_title == table['title'], "Expected the alert title to be '#{table['title']}' but was '#{actual_title}'")
  assert(actual_message == table['message'], "Expected the alert message to be '#{table['message']}', but was '#{actual_message}'")
end

Then(/^I should see the following error messages:$/) do |table|
  failures = Array.new
  table = Toolbox.eval_table_array(table.raw.flatten)
  displayed_errors = Array.new
  Finder.every({locator: "span.text-danger"}).each do |el|
    displayed_errors << el.text
  end
  table.each do |message|
    failures << "Expected to see an error message with '{message}'." unless displayed_errors.include?(message)
  end
  assert(failures.empty?, "Got the following failures: \n\t#{failures.join("\n\t")}")
end

Then(/^I should not see an element with:$/) do |table|
  table = Toolbox.eval_table(table.rows_hash)
  type = table.delete('type')
  value = table.delete('value')
  within = table.delete('within')
  if within then
    table[:el] = Finder.one(locator: within)
  end
  case type
  when 'css'
    assert(Finder.no_css?(value, table), "Expected to NOT see an element with css '#{value}'.")
  when 'link'
    assert(Finder.no_link?(value, table), "Expected to NOT see a link with value '#{value}'.")
  when 'button'
    assert(Finder.no_button?(value, table), "Expected to NOT see a button with value '#{value}'.")
  else
    raise "Unknown type"
  end
end

Then(/^an* "([^"]*)" file should be in the downloads folder$/) do |name|
  assert(DownloadHelpers.has_file?(name), "Expected the download folder to have a file named '#{name}'")
end
