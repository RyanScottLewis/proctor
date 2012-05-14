module ControllerHelpers
  def json_request(action, options={}, verb=:get)
    send(verb, action, { format: :json }.merge(options))
  end
end