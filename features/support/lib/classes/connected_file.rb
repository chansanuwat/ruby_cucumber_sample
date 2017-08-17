class ConnectedFile

  def initialize data = {}
    @data = data
    unless @data['existing'] then
      generate(@data)
    end
  end

  def generate data
    unique = Toolbox.string_size({'size' => 5})
    @data.merge!(data)
    @data['Name'] = "QE Automation File #{unique}.zip"
    Tracker.log @data['Name']
    @data['File Path'] = File.absolute_path("#{@data['Path']}/#{@data['Name']}")
    @data['Content'] = "QE automatically generated file #{unique}"
    File.open(@data['File Path'], 'w') { |f|
      f.puts @data['Content']
    }
  end

  def name
    return @data['Name']
  end

  def path
    return @data['File Path']
  end

  def directory
    return @data['Path']
  end

  def content
    return @data['Content']
  end

  def id
    return @data['Id']
  end
  
  def method_missing(name, *args, &block)
    if @data.keys.include?(name.to_s) then
      return @data[name.to_s]
    else
      super
    end
  end

end