module Navigator

  extend Capybara::Angular::DSL
  
  def self.home
    Tracker.log("Visiting home page")
    visit '/'
  end

  def self.authenticate auth
    Tracker.log("Checking authentication state")
    acct_locator = "nav.navbar-static-side ul.dropdown-menu li a"
    if all(acct_locator, visible: false).empty? then
      home
    end
    unless all(acct_locator, visible: false).empty? then
      v = Finder.value_of_attribute({locator: acct_locator, attribute: 'ui-sref', options: {visible: false}}).match(/accountId: '([^']+)'/).captures[0]
      unless v == auth['account_id'] then
        Tracker.log("Current authenticated user does not match requested user.")
        Tracker.log("Resetting the Capybara session")
        Capybara.reset_session!
        login(auth)
      end
    else
      login(auth)
    end
  end

  def self.login auth
    Tracker.log("Logging in")
    home
    Form.input('login', auth['email'])
    Form.input('password', auth['password'])
    Form.submit('Login')
  end

  def self.load_project name
    Tracker.log("Loading project '#{name}'")
    if all('.project-list').empty? then
      Tracker.log("Could not find project list")
      home
    end
    find('.project-list').click_link(name)
  end

  def self.load_tab name
    Tracker.log("Loading tab '#{name}'")
    find('.ibox-title .nav-tabs').click_link(name)
    if name == 'Chat' then
      Toolbox.wait_for_element("ul#chat-discussion-list")
    end
  end

  def self.load_subtab name
    Tracker.log("Loading subtab '#{name}'")
    find('.ibox-content .nav-tabs').click_link(name)
  end

  def self.visit_account_details
    Tracker.log("Loading account details")
    click_el(Finder.one({locator: 'div.profile-element a.dropdown-toggle'}))
    link('Account', Finder.one({locator: 'ul.dropdown-menu'}))
  end

  def self.button locator
    Tracker.log("Clicking button '#{locator}'")
    click_button(locator)
  end

  def self.span_button locator
    Tracker.log("Clicking button '#{locator}'")
    click_el(Finder.one(locator: locator))
  end

  def self.link locator, el = nil
    Tracker.log("Clicking link '#{locator}'")
    if el then
      el.click_link(locator)
    else
      click_link(locator)
    end
  end

  def self.click_el el
    Tracker.log("Clicking element")
    el.click
  end

end