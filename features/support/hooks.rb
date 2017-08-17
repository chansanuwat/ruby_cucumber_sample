Before do |scenario|
  $count = 0
  $current_steps = scenario.test_steps
  $current_steps.delete_if do |x|
    x.name.match(/^AfterStep/)
  end
  $scenario_name = scenario.name
  if $logdir then
    file = "#{$logdir}/#{scenario.name.gsub(' ','_')}.log"
    if File.exists?(file) then
      File.truncate file, 0
    end
    $logger = Tracker.new({file: file, on: true})
  else
    Tracker.break
  end
  Tracker.puts "Scenario: #{scenario.name}"
  Tracker.log "#{$current_steps[$count].name}", "Step Name"
  $current = Hash.new
  Capybara.use_default_driver
end 

Before('@multiple_sessions') do
  $sessions = {}
end

After('@multiple_sessions') do
  $sessions.each do |name,session|
    session.current_window.close
  end
  Capybara.session_name = :default
  Capybara.reset_session!
end

Before('@download_file') do
  DownloadHelpers.clear_downloads
end

After('@download_file') do
  DownloadHelpers.clear_downloads
end

After('@upload_file') do
  FileHelper.clear_files
end

After('@devtest') do
  # debugger
  # nil
end


AfterStep do |scenario|
  $count += 1
  Tracker.log("#{$current_steps[$count].name}", "Step Name") if $count < $current_steps.length

  if ['all','whitelist'].include?(JS_Errors) then
    errors = Capybara.page.driver.browser.manage.logs.get(:browser)
      .select {|e| e.level == "SEVERE" }
      .map(&:message)
      .to_a

    if JS_Errors == 'whitelist' then
      JS_Whitelist.each do |pattern|
        errors.delete_if { |x| x.match(pattern)}
      end
    end

    unless errors.empty?
      raise DriverJSError, errors.join("\n\n")
    end
  end
end

After do |scenario|
  Tracker.puts "Scenario Status: #{scenario.status.to_s.upcase}"
  Tracker.puts scenario.exception if scenario.failed?
  $reporting_logger = Tracker.content
  Tracker.flush
  Capybara.reset_session! if Reset_session
end