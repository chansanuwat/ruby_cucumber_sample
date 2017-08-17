class Account

  def initialize opts = {}
    @data = opts
  end

  def edit data
    no_save = data.delete('no_save')
    Navigator.link('Edit')
    fields = {
      'First Name'  => 'firstName',
      'Last Name'   => 'lastName',
      'Company'     => 'company',
      'Title'       => 'title'
    }
    data.each do |field,value|
      Form.input(fields[field], value)
      @data[field.downcase.gsub(' ', '_')] = value
    end
    Form.submit('Save changes') unless no_save
  end

  def full_name
    return "#{@data['first_name']} #{@data['last_name']}"
  end
  
  def method_missing(name, *args, &block)
    if @data.keys.include?(name.to_s) then
      return @data[name.to_s]
    else
      super
    end
  end

end

