Given(/^I have a default "([^"]+)" as "([^"]+)"$/) do |default, name|
  $current[name] = Environment[default]
end

Given(/^I have a unique string as "([^"]+)"$/) do |name|
  $current[name] = Toolbox.uniq
end

Given(/^I have a unique "([^"]+)" as "([^"]+)" with:$/) do |type,name,table|
  table = Toolbox.eval_table(table.rows_hash)
  case type.downcase
  when 'float'
    value = rand * (table['max']-table['min']) + table['min']
    value = sprintf("%.#{table['decimal']}f", value) if table['decimal']
  when 'string'
    value = Toolbox.string_size(table)
  when 'integer'
    value = rand(table['min']..table['max'])
  else
    value = Toolbox.uniq
  end
  $current[name] = value.to_s
end

Given(/^I have a unique string as "([^"]+)" with:$/) do |name,table|
  table = Toolbox.eval_table(table.rows_hash)
  $current[name] = Toolbox.string_size(table)
end

Given(/^I store the current time as "([^"]+)" with format "([^"]+)"$/) do |name,format|
  $current[name] = Time.now.strftime(format.strip)
end

Given(/^I switch to the "([^"]+)" session$/) do |name|
  Capybara.session_name = name.to_sym
  unless name == 'default'
    $sessions[name] = Capybara.current_session unless $sessions[name]
  end
end

Given(/^I get the current "([^"]+)" as "([^"]+)"$/) do |type,identifier|
  case type
  when 'user name'
    $current[identifier] = Finder.text_of({locator: "nav.navbar-static-side li.nav-header strong"})
  else
    raise "Unknown type: #{type}"
  end
end

When(/^I wait for "([^"]+)" seconds?$/) do |count|
  sleep count.to_f
end