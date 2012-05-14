window.Client = class Client extends Spine.Model
  @configure "Client", "name", "created_at", "updated_at"
  @extend Spine.Model.Ajax
  @hasMany 'projects', 'Project'
  
  toJSON: ->
    result = {}
    result[ @constructor.className.underscore() ] = @attributes()
      
    result
  
  @fromJSON: (resources) ->
    return unless resources
    
    if typeof resources is 'string'
      resources = JSON.parse(resources)
    
    if Spine.isArray(resources)
      (new @(resource['client']) for resource in resources)
    else
      new @(resources['client'])