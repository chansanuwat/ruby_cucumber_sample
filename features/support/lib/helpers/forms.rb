module Form

  extend Capybara::Angular::DSL

  def self.input locator, value, opts = {}
    Tracker.log("Filling input: #{locator} with #{value}")
    if opts[:by] then
      case opts[:by]
      when :css
        find(locator).set(value)
      else
        fill_in locator, with: value
      end
    else
      fill_in locator, with: value
    end
  end

  def self.pick locator, value
    Tracker.log("Selecting: #{value} from #{locator}")
    select(value, from: locator)
  end

  def self.submit locator
    Tracker.log("Submitting. Button = #{locator}")
    click_button locator
  end

end