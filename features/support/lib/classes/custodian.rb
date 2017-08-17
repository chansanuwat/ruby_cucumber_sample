class Custodian

  def initialize data
    @data = data
    if @data['existing'] then
      if @data['Name'] then
        @data['First Name'], @data['Last Name'] = @data['Name'].split(' ')
      end
    else
      add(@data)
    end
  end

  def add data
    Navigator.link('New Custodian')
    Form.input('firstName', data['First Name'])
    Form.input("input[ng-model='ctrl.custodian.lastName']", data['Last Name'], by: :css)
    Form.input("input[ng-model='ctrl.custodian.email']", data['Email'], by: :css)
    Form.submit('Save changes') unless data['no_save']
  end

  def edit data
    no_save = data.delete('no_save')

    fields = {
      'First Name'  => 'firstName',
      'Last Name'   => 'lastName',
      'Email'       => 'email'
    }

    Navigator.link('Edit')

    data.each do |field,value|
      Form.input(fields[field], value)
      @data[field] = value
    end
    Form.submit('Save changes') unless no_save
  end

  def delete
    Navigator.button('Delete')
    sleep 1
    Navigator.button('Yes, delete it!')
  end

  def full_name
    return "#{@data['First Name']} #{@data['Last Name']}"
  end

  def email
    return @data['Email']
  end

end