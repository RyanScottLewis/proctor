class ResourcesObserver < ActiveRecord::Observer
  observe :client, :project, :iteration, :example_group, :example
  
  def after_create(resource)
    publish(:create, resource)
  end
  
  def after_update(resource)
    publish(:update, resource)
  end
  
  def after_destroy(resource)
    publish(:destroy, resource.id)
  end
  
  private
  
  def publish(action, resource)
    unless Rails.env == 'test'
      resource_name = resource.class.to_s.demodulize.underscore.pluralize
      channel = "/#{resource_name}/#{action}"
      message = resource.as_json(:root => false)
      
      FayeRails.client().publish(channel, message)
    end
  end
end
