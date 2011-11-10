module SpecHelper
  module VideoFileSpecHelper
    def current_path
      File.join( File.dirname(__FILE__), "../" )
    end
    
    def fixture_file_path
      File.join(current_path, "fixtures")
    end
    
    def valid_3g_file_path
      File.join(fixture_file_path, "test.3gp")
    end
    
    def valid_mpeg_file_path
      File.join(fixture_file_path, "test.mpeg")
    end
  end
end
