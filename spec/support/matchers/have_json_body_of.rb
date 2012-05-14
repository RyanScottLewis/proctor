RSpec::Matchers.define :have_json_body_of do |input|
  match do |response|
    @result = JSON.parse(input.as_json.to_json)
    response.body.json.should == @result
  end
  
  failure_message_for_should do |response|
    <<-EOF
      Response body JSON message should equal input as JSON"
      Expected:
        #{response.body.json}
      Got:
        #{@result}
    EOF
  end
  
  failure_message_for_should_not do |response|
    <<-EOF
      Response body JSON message should not equal input as JSON"
      Expected anything but:
        #{response.body.json}
      Got:
        #{@result}
    EOF
  end
end
