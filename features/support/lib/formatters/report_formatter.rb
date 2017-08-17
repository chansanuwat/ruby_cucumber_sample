require 'net/http'
require 'json'

module Dashboard  
  class Reporter
    
    def initialize(step_mother, io, options)
      @reporter = ReporterAPI.new
      @reporter.project($reporterConf['project'])
      @reporter.test($reporterConf['test'])
    end

    def scenario_name(type,name,file_line,i)
        @outline = false
        @name = name
        @start = Time.now
    end
    
    def before_examples_array(scenario)
      @outline = true
      @row_num = 0
    end
    
    def after_steps step_collection
      # @steps = step_collection.collect{|x| x.name}.join("\n")
    end
    
    def before_steps step_collection
      @steps = ""
    end
    
    def after_step step
      @steps << "#{step.name}\n"
      if step.multiline_arg then
        if step.multiline_arg.kind_of?(Cucumber::Core::Ast::DocString) then
          @steps << "\"\"\"\n#{step.multiline_arg}\n\"\"\"\n"
        elsif step.multiline_arg.kind_of?(Cucumber::Core::Ast::DataTable) then
          step.multiline_arg.raw.each do |row|
            @steps << "| #{row.join(' | ')} |\n"
          end
        else

        end
        @steps.strip
      end
    end
    
    def after_multiline_arg scenario
      
    end
    
    def after_table_row(scenario)
      if @outline then
        if scenario.kind_of?(Cucumber::Formatter::LegacyApi::Ast::ExampleTableRow) then
          if @row_num == 0 then
            @header = scenario.name
          else
            data = {'name'=>"#{@name}-#{@row_num}", 'description'=>"#{@steps}\nExamples:\n#{@header}\n#{scenario.name}"}
            scen = @reporter.scenario(data)
            if scenario.status == :undefined then
              status = :skipped
            else
              status = scenario.status
            end
            result_data = {'scenario_id'=>scen['_id'],'message'=>check_status(scenario),'result'=>status.to_s.downcase, 'duration' => (Time.now - @start)}
            if $reporting_logger then
              $reporting_logger.kind_of?(Array) ? tmp = $reporting_logger.join("\n") : tmp = $reporting_logger
              result_data[:notes] = tmp.to_s.gsub(%r{</?[^>]+?>}, '')
            end
            @reporter.result result_data
            @exception = nil
          end
          @row_num += 1
        end
      end
    end
    
    def after_feature_element(scenario)
      unless @outline then
        data = {'name'=>scenario.name,'description'=>@steps}
        scen = @reporter.scenario(data)
        if scenario.status == :undefined then
          status = :skipped
        else
          status = scenario.status
        end
        result_data = {'scenario_id'=>scen['_id'],'message'=>check_status(scenario),'result'=>status.to_s.downcase, 'duration' => (Time.now - @start)}
        if $reporting_logger then
          $reporting_logger.kind_of?(Array) ? tmp = $reporting_logger.join("\n") : tmp = $reporting_logger
          result_data['notes'] = tmp.to_s.gsub(%r{</?[^>]+?>}, '')
        end
        @reporter.result result_data
        @exception = nil
      end
    end

    def exception(exception, status)
      @exception = exception
    end

    def check_status(scenario)
      case scenario.status
      when :undefined
        message = 'Skipped'
      when :passed
        message = 'All expectations met'
      when :failed
        message = @exception.to_s.gsub(%r{</?[^>]+?>}, '')
      else
        message = 'No Message'
      end
      return message
    end
  end
end

class ReporterAPI
    
  def initialize
    @base = 'REMOVED'
    @port = 3000
    @json_headers = {
      'Content-Type' => "application/json",
      'Accepts' => "application/json"
    }
  end
  
  def project hsh
    data = JSON.generate({
        'name'=> 'No name',
        'description' => 'No description'}.merge(hsh))
    resp = post('/projects', data)
    return @project = JSON.parse(resp.body)['data']
  end
  
  def test hsh = {}
    data = JSON.generate({
        'project_id'  => @project['_id'],
        'name'        => 'No name',
        'description' => 'No description',
        'environment' => 'No environment',
        'notes'       => 'No notes'
    }.merge(hsh))
    resp = post('/tests', data)
    return @test = JSON.parse(resp.body)['data']
  end
  
  def scenario hsh
    data = JSON.generate({
        'name' => 'No name',
        'project_id' => @project['_id'],
        'description' => 'No description'}.merge(hsh))
    resp = post('/scenarios', data)
    return @scenario = JSON.parse(resp.body)['data']
  end
  
  def result hsh
    data = JSON.generate([{
        "result" => 'skipped',
        "test_id" => @test['_id'],
        "scenario_id" => @scenario['_id'],
        "message" => 'No message',
        "notes" => 'No notes',
        "duration" => 0.0}.merge(hsh)])
    resp = post('/results', data)
    return JSON.parse(resp.body)
  end
  
  def new_connection
    return Net::HTTP.new(@base, @port)
  end
  
  def post path, data, json_headers=@json_headers
    return request{new_connection.post(path,data,json_headers)}
  end

  def put path, data, json_headers=@json_headers
    return request{new_connection.put(path,data,json_headers)}
  end

  def get path, json_headers=@json_headers
    proc = Proc.new {new_connection.get(path,json_headers)}
    return request(&proc)
  end
  
  def request
    begin
      return yield
    rescue Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      puts "Could not submit request to the Dashboard"
      puts e.code
      puts e.message
    end
  end
end

