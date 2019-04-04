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
    @formats = []
    @unknown_formats = []

    check_formats(format_string)
    pp @formats
  end

  def result
    formats.map { |el| FORMAT_LIST[el] }.join('-')
  end

  def valid?
    unknown_formats.empty?
  end

  private

  attr_writer :formats, :unknown_formats

  def check_formats(string)
    puted_formats = string.split(',')

    if puted_formats.empty?
      self.formats = FORMAT_LIST.keys
      return
    end

    puted_formats.each do |format|
      if FORMAT_LIST[format.to_sym]
        formats << format.to_sym
      else
        unknown_formats << format
      end
    end
  end
end
