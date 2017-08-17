class Task

  Fields = {
    "Title"       => ['text', 'title'],
    "Assigned To" => ['select', 'assignedTo'],
    "Status"      => ['select', 'status'],
    "Due"         => ['text', 'dueDate'],
    "Priority"    => ['select', 'priority'],
    "Description" => ['text', 'description'],
    "Notes"       => ['text', 'notes']
  }

  def initialize data
    @data = data
    unless @data['existing'] then
      add(@data)
    end
  end

  def add data
    no_save = data.delete('no_save')
    Navigator.link('New Task')
    form_fill(data)
    Form.submit('Save changes') unless no_save
  end

  def edit data
    no_save = data.delete('no_save')

    form_fill(data)
    Form.submit('Save changes') unless no_save
  end

  def form_fill data
    data.each do |field,value|
      input = Fields[field]
      if input[0] == 'select' then
        Form.pick(input[1], value)
      else
        Form.input(input[1], value)
      end
      @data[field] = value
    end
  end
  
  def method_missing(name, *args, &block)
    tmp = name.to_s.split('_').map(&:capitalize).join(' ')
    if @data.keys.include?(tmp) then
      return @data[tmp]
    else
      super
    end
  end

end