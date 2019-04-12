class CheckFormat
  FORMAT_LIST = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :formats, :unknown_formats

  def initialize(format_string = '')
    @time = Time.now
    @format_string = format_string
    @formats = []
    @unknown_formats = []
  end

  def parse
    check_formats
    self
  end

  def result
    @time.strftime(formats.map { |el| FORMAT_LIST[el] }.join('-'))
  end

  def valid?
    unknown_formats.empty?
  end

  private

  def check_formats
    puted_formats = @format_string.split(',')

    puted_formats.each do |format|
      if FORMAT_LIST[format.to_sym]
        @formats << format.to_sym
      else
        @unknown_formats << format
      end
    end
  end
end
