Given(/^I have a generated file as "([^"]+)"$/) do |name|
  $current[name] = ConnectedFile.new({'Path' => FilesDirectory})
end

When(/^I go to the file viewer for a file matching:$/) do |table|
  table = Toolbox.eval_table(table.rows_hash)
  unless $current["ConnectedFileTable"] then
    $current["ConnectedFileTable"] = Kernel.const_get("ConnectedFileTable").new(false)
  end
  row = $current["ConnectedFileTable"].find_row_with(table.delete('match'))
  raise "Could not find a matching file" if row.nil?
  $current['windows'] ||= {}
  $current['windows']['default'] = Capybara.current_window.handle
  $current['windows']['file viewer'] = Capybara.window_opened_by {Navigator.link(row["Display Name"], row["Row"])}
  Capybara.switch_to_window($current['windows']['file viewer'])
end

When(/^I download a file from the list matching:$/) do |table|
  table = Toolbox.eval_table(table.rows_hash)
  unless $current["ConnectedFileTable"] then
    $current["ConnectedFileTable"] = Kernel.const_get("ConnectedFileTable").new(false)
  end
  row = $current["ConnectedFileTable"].find_row_with(table.delete('match'))
  raise "Could not find a matching file" if row.nil?
  Navigator.click_el(Finder.one({locator: "a#button_download_#{row['Id'].split('-')[1]}"}))
  DownloadHelpers.wait_for_download
end

When(/^I upload the following files:$/) do |table|
  file_count = FileHelper.displayed_count
  # Navigator.span_button("span.btn-file")
  table = Toolbox.eval_table_array(table.raw.flatten)
  begin
    Capybara.attach_file('fsp-fileUpload', table, multiple: true, visible: false)
  rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
    Tracker.log(e.message, 3)
  end
  0.upto(100) do
    break if FileHelper.displayed_count > file_count
    sleep 0.25
  end
end