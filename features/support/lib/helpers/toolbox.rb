require 'Date'

module Toolbox
  
  def self.uniq opts={}
    s = Time.now.strftime('%s%3N')
    return "#{opts[:pre] || opts['pre']}#{s}#{opts[:suf] || opts['suf']}"
  end
  
  def self.string_size opts = {}
    opts = {'size' => 10, 'pre' => '', 'suf' => ''}.merge(opts)
    opts['size'] = opts['size'] - opts['pre'].length - opts['suf'].length
    return "#{opts['pre']}#{((0...opts['size']).map { ('a'..'z').to_a[rand(26)] }.join)}#{opts['suf']}"
  end
  
  def self.eval_table hsh
    hsh.each do |k,v|
      hsh[k] = eval(v)
    end
    return hsh
  end

  def self.eval_table_array arr
    arr.collect!{|x| eval(x)}
    return arr
  end
  
  def self.wait time = WaitTime
    (time * 4).times do
      begin
        p "Waiting for jquery"
        break if Capybara.page.evaluate_script('jQuery.active').zero?
      rescue
      end
      sleep 0.25
    end
  end
  
  def self.wait_for_element loc, time = WaitTime
    (time*4).times do
      break if Capybara.all(loc).length > 0
      sleep 0.25
    end
  end

  def self.days_from_now days, f = "%m/%d/%Y"
    return (Time.now.to_date + days.to_i).strftime(f)
  end
  
end