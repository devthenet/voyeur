module Voyeur
  class Media
    attr_reader :filename
    attr_reader :raw_duration
    
    def initialize(options)
      @filename = options[:filename]
      self.get_info
    end
    
    def get_info
      output = ''
      status = Open4::popen4("ffmpeg -i #{@filename}") do |pid, stdin, stdout, stderr|
        output = stderr.read.strip
      end
      @raw_duration = $1 if output =~  /Duration: (\d+:\d+:\d+.\d+)/ 
    end

    def convert(options)
      converter = Voyeur::Converter.create(format: options[:to])
      
      if block_given?
        converter.convert(video: self,
                          output_filename: options[:output_filename],
                          output_path: options[:output_path]) do |time|
                            yield time
                          end
      else
        converter.convert(video: self,
                          output_filename: options[:output_filename],
                          output_path: options[:output_path])
      end
    end

    def convert_to_html5(options = nil)
      [:mp4, :ogv, :webm].each do |f|
        options_hash = {to: f}
        options_hash.merge!(options) if options
        convert(options_hash)
      end
    end
  end
end
