class CustodianDetail

  def initialize
    @data = Hash.new
    titles = Finder.every({locator: 'div.ibox-content dt'})
    values = Finder.every({locator: 'div.ibox-content dd'})
    titles.each_with_index do |title_el, i|
      @data[Finder.text_of({this_el: title_el}).downcase.gsub(' ', '_')] = Finder.text_of({this_el: values[i]})
    end
  end
  
  def method_missing(name, *args, &block)
    if @data.keys.include?(name.to_s.downcase) then
      return @data[name.to_s.downcase]
    else
      super
    end
  end

end