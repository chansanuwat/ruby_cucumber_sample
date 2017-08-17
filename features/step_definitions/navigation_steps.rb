Given(/^I am logged in as an? "([^"]+)" user$/) do |type|
  Navigator.authenticate(Users[type])
end

Given(/^I am on the "([^"]+)" tab for project "([^"]+)"$/) do |tab, project|
  current_project = Finder.current_project?
  if current_project == '' then
    Navigator.home
    Navigator.load_project(project)
  else
    if current_project != project then
      Navigator.load_project(project)
    end
  end

  Navigator.load_tab(tab)
end

Given(/^I am on the account details for the user$/) do
  Navigator.visit_account_details
end



Given(/^I am on the "([^"]+)" subtab$/) do |tab|
  Navigator.load_subtab(tab)
end