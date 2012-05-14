window.Project = class Project extends Spine.Model
  @configure "Project", "name", "created_at", "updated_at"
  @extend Spine.Model.Ajax
  @belongsTo 'client', 'Client'
  @hasMany 'iterations', 'Iteration'
  
  @fromJSON: (resources) ->
    return unless resources
    
    if typeof resources is 'string'
      resources = JSON.parse(resources)
    
    if Spine.isArray(resources)
      (new @(resource['project']) for resource in resources)
    else
      new @(resources)['project']
  
  examples: () ->
    _.flatten @iterations().all().map (iteration) -> iteration.examples()
  
  finished_iterations: () ->
    @iterations().select (iteration) ->
      iteration.finished_examples().length == iteration.example_count