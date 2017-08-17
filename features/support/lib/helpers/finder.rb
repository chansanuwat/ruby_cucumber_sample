module Finder

  extend Capybara::Angular::DSL

  def self.every opts
    Tracker.log("Looking for every #{opts[:locator]}")
    options = opts[:options] || {visible: true}
    opts = {kind: :css}.merge(opts)
    t = Timer.new("FindEvery")
    if opts[:el] then
      results = opts[:el].all(opts[:kind], opts[:locator], options)
    else
      results = all(opts[:kind], opts[:locator], options)
    end
    t.stop
    return results
  end

  def self.one opts
    Tracker.log("Looking for one #{opts[:locator]}")
    options = opts[:options] || {visible: true}
    opts = {kind: :css}.merge(opts)
    t = Timer.new("FindOne")
    if opts[:el] then
      result = opts[:el].find(opts[:kind], opts[:locator], options)
    else
      result = find(opts[:kind], opts[:locator], options)
    end
    t.stop
    return result
  end

  def self.one_by_index i, opts
    Tracker.log("Looking for one #{opts[:locator]} by index #{i}")
    return every(opts)[i]
  end

  def self.text_of opts
    Tracker.log("Getting text of an element")
    if opts[:this_el] then
      el = opts[:this_el]
    else
      el = one(opts)
    end
    t = Timer.new("GetText")
    text = el.text.strip
    t.stop
    Tracker.log("Text = '#{text}'")
    return text
  end

  def self.value_of_attribute opts
    Tracker.log("Getting value of attribute #{opts[:attribute]}")
    t = Timer.new("GetAttributeValue")
    if opts[:this_el] then
      att = opts[:this_el][opts[:attribute]]
    else
      att = one(opts)[opts[:attribute]]
    end
    t.stop
    Tracker.log("Attribute value = '#{att}'")
    return att
  end

  def self.current_project?
    Tracker.log("Checking current project")
    if has_css?("div.ibox-title h2") then
      proj_name = text_of({locator: "div.ibox-title h2"})
      Tracker.log("Project name = '#{proj_name}'")
      return proj_name
    else
      Tracker.log("Did not find a project name")
      return ""
    end
  end

  def self.current_tab?
    Tracker.log("Checking current project")
    if has_css?("div.ibox-title ul.nav-tabs li.active") then
      tab_name = text_of({locator: "div.ibox-title ul.nav-tabs li.active"})
      Tracker.log("Tab name = #{tab_name}")
      return tab_name
    else
      Tracker.log("Did not find a tab name")
      return ""
    end
  end

  def self.no_css? value, opts = {}
    opts = {visible: true}.merge(opts)
    opts = opts.inject({}){|tmp,(k,v)| tmp[k.to_sym] = v; tmp}
    if opts[:el] then
      el = opts.delete(:el)
      return el.has_no_css?(value, opts)
    else
      return has_no_css?(value, opts)
    end
  end

  def self.no_link? value, opts = {}
    opts = {visible: true}.merge(opts)
    opts = opts.inject({}){|tmp,(k,v)| tmp[k.to_sym] = v; tmp}
    if opts[:el] then
      el = opts.delete(:el)
      return el.has_no_link?(value, opts)
    else
      return has_no_link?(value, opts)
    end
  end

  def self.no_button? value, opts = {}
    opts = {visible: true}.merge(opts)
    opts = opts.inject({}){|tmp,(k,v)| tmp[k.to_sym] = v; tmp}
    if opts[:el] then
      el = opts.delete(:el)
      return el.has_no_button?(value, opts)
    else
      return has_no_button?(value, opts)
    end
  end
  
end