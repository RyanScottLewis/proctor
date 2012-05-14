module ActionController
  module TestResponseBody
    class Body < String
      def initialize(body)
        @parsed_body ||= { :plain => body.to_s }
        
        super
      end
      
      def plain
        @parsed_body[:plain]
      end
      
      def json
        @parsed_body[:json] ||= JSON.parse(plain)
      end
      
      def yaml
        @parsed_body[:yaml] ||= YAML.dump(plain)
      end
      
      def to_s
        plain
      end
    end
    
    def body
      @body_with_wrapping_class ||= Body.new(super)
    end
  end
  
  class TestResponse
    include TestResponseBody
  end
end
