window.Iteration = class Iteration extends Spine.Model
  @configure 'Iteration', 'example_count', 'state', 'created_at', 'updated_at'
  @extend Spine.Model.Ajax
  @belongsTo 'project', 'Project'
  @hasMany 'exampleGroups', 'ExampleGroup'
  
  @fromJSON: (resources) ->
    return unless resources
    
    if typeof resources is 'string'
      resources = JSON.parse(resources)
    
    if Spine.isArray(resources)
      (new @(resource['iteration']) for resource in resources)
    else
      new @(resources['iteration'])
  
  examples: ->
    Example.select (example) => example.iteration().id == @.id
  
  finished_examples: ->
    Example.select (example) => example.iteration().id == @.id && example.state != 'unknown'
  
  passing_examples: ->
    Example.select (example) => example.iteration().id == @.id && example.state == 'passing'
  
  pending_examples: ->
    Example.select (example) => example.iteration().id == @.id && example.state == 'pending'
  
  failing_examples: ->
    Example.select (example) => example.iteration().id == @.id && example.state == 'failing'
  
  isFinished: ->
    @finished_examples().length == @example_count
  
  toTree: ->
    @exampleGroups().all().map (exampleGroup) -> exampleGroup.toTree()