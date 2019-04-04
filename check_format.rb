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
    @format_string = format_string
    @formats = []
    @unknown_formats = []
  end

  def parse
    if format_string.nil? || format_string.empty?
      self.formats = FORMAT_LIST.keys
    else
      check_formats
    end
  end

  def result
    formats.map { |el| FORMAT_LIST[el] }.join('-')
  end

  def valid?
    unknown_formats.empty?
  end

  private

  attr_reader :format_string
  attr_writer :formats, :unknown_formats

  def check_formats
    puted_formats = format_string.split(',')

    puted_formats.each do |format|
      if FORMAT_LIST[format.to_sym]
        formats << format.to_sym
      else
        unknown_formats << format
      end
    end
  end
end
