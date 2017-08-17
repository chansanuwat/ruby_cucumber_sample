class Tracker
  
  attr_accessor :standard_text
  
  def initialize opts={}
    @@on = opts[:on] || false
    @@file = opts[:file] || false
    @@tabbing = opts[:tabbing] || 20
    @@content = []
  end
  
  def log text, type=0
    self.log text, type
  end
  
  def self.log text, type=0
    if type.kind_of?(String) then
      prefix = "[#{type}]:"
    else
      prefix = ['[INFO]:','[DEBUG]:','[WARNING]:','[ERROR]:','[TIMER]:'][type]
    end
    self.puts "#{self.tab(prefix)} #{text}"
  end
  
  def break count=1
    self.break count
  end
  
  def self.break count=1
    count.times do
      self.puts
    end
  end
  
  def self.puts text=''
    if @@on then
      if @@file then
        File.open(@@file, 'a+') do |f|
          f.puts text
        end
      end
      @@content << text
    end
  end
  
  def self.tab text
    spacing = ''
    (@@tabbing - text.length).times do
      spacing << ' '
    end
    return "#{spacing}#{text}"
  end
  
  def self.close
    @@file.close
  end

  def self.content
    @@content
  end

  def self.flush
    @@content = []
  end
  
end