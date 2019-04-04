require_relative 'check_format'

class App

  def initialize
    @time = Time.at(0)
  end

  def call(env)
    @request = Rack::Request.new(env)
    path = @request.path_info

    if @request.path_info == '/time' && @request.request_method == 'GET'
      format = @request.params['format'] || ''
      return render_time(CheckFormat.new(format))
    end

    compose_response("Unknown page #{path}\n", 404)
  end

  private

  def compose_response(body = '', status = 200)
    Rack::Response.new(body, status, 'Content-Type' => 'text/plain')
  end

  def render_time(formats)
    if formats.valid?
      compose_response(@time.strftime(formats.result))
    else
      compose_response("Unknown time format [#{formats.unknown_formats.join(' ')}]", 400)
    end
  end
end
