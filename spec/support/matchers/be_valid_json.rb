RSpec::Matchers.define :be_valid_json do
  match do |response|
    begin
      JSON.parse(response.body)
      
      true
    rescue => e
      @error_message = e.message
      
      false
    end
  end
  
  failure_message_for_should do |response|
    "Response body should be valid JSON: #{@error_message}"
  end
  
  failure_message_for_should_not do |response|
    "Response body should not be valid JSON: #{@error_message}"
  end
end
