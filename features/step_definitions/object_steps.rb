Given(/I have an? "([^"]+)" table object$/) do |object_name|
  $current["#{object_name}Table"] = Kernel.const_get("#{object_name}Table").new(false)
end

When(/^I add a new "([^"]*)" with:$/) do |object_name,table|
  table = Toolbox.eval_table(table.rows_hash)
  $current[object_name] = Kernel.const_get(object_name).new(table)
end

When(/^I capture the current "([^"]+)" data$/) do |object_name|
  $current[object_name] = Kernel.const_get(object_name).new({parse: true})
end

When(/^I edit the "([^"]+)" with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new
  end
  $current[object_name].edit(table)
end

When(/^I edit a "([^"]+)" with:$/) do |object_name, table|
  table = Toolbox.eval_table(table.rows_hash)
  unless $current["#{object_name}Table"] then
    $current["#{object_name}Table"] = Kernel.const_get("#{object_name}Table").new(false)
  end
  row = $current["#{object_name}Table"].find_row_with(table.delete('match'))
  row['existing'] = true
  case object_name
  when 'Custodian'
    Navigator.click_el(row['Link'])
    Navigator.link('Details')
  when 'Task'
    Navigator.click_el(Finder.one({locator: row['Link'], kind: :xpath}))
  else
    raise "Don't know what to do with object type #{object_name}'"
  end
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(row)
  end
  $current[object_name].edit(table)
end

When(/^I delete a "([^"]+)" from the list with:$/) do |object_name, table|
  object_name = object_name.gsub(' ', '')
  data = Kernel.const_get("#{object_name}Table").new(false)
  table = Toolbox.eval_table(table.rows_hash)
  row = data.delete(table.delete('match'))
  raise "Could not find a result matching #{match_data}" if row.nil?
  row['existing'] = true
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(row)
  end
end

When(/^I delete a "([^"]+)" from the details screen with:$/) do |object_name, table|
  data = Kernel.const_get("#{object_name}Table").new(false)
  table = Toolbox.eval_table(table.rows_hash)
  row = data.find_row_with(table.delete('match'))
  raise "Could not find a result matching #{match_data}" if row.nil?
  row['existing'] = true
  case object_name
  when 'Custodian'
    Navigator.click_el(row['Link'])
    Navigator.link('Details')
  else
    raise "Don't know what to do with object type #{object_name}'"
  end
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(row)
  end
  $current[object_name].delete
end

When(/^I go to the details screen for a "([^"]+)" with:$/) do |object_name, table|
  data = Kernel.const_get("#{object_name}Table").new(false)
  table = Toolbox.eval_table(table.rows_hash)
  match_data = table.delete('match')
  row = data.find_row_with(match_data)
  raise "Could not find a result matching #{match_data}" if row.nil?
  row['existing'] = true
  case object_name
  when 'Custodian'
    Navigator.click_el(row['Link'])
    Navigator.link('Details')
  else
    raise "Don't know what to do with object type #{object_name}'"
  end
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(row)
  end
end

When(/^I go to the "([^"]+)" tab for a "([^"]+)" with:$/) do |tab_name, object_name, table|
  data = Kernel.const_get("#{object_name}Table").new(false)
  table = Toolbox.eval_table(table.rows_hash)
  match_data = table.delete('match')
  row = data.find_row_with(match_data)
  raise "Could not find a result matching #{match_data}" if row.nil?
  row['existing'] = true
  case object_name
  when 'Custodian'
    Navigator.click_el(row['Link'])
    Navigator.load_subtab(tab_name)
  else
    raise "Don't know what to do with object type #{object_name}'"
  end
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(row)
  end
end

When(/^I parse the "([^"]+)"$/) do |object_name|
  object_name = object_name.gsub(' ', '')
  if $current[object_name] then
    $current[object_name].parse
  else
    $current[object_name] = Kernel.const_get(object_name).new(true)
  end
end

When(/^I search the "([^"]*)" for "([^"]*)"$/) do |object_name, term|
  object_name = object_name.gsub(' ', '')
  unless $current[object_name] then
    $current[object_name] = Kernel.const_get(object_name).new(false)
  end
  $current[object_name].search(term)
end