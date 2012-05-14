window.Example = class Example extends Spine.Model
  @configure "Example", 'state', "description", "created_at", "updated_at"
  @extend Spine.Model.Ajax
  @belongsTo 'parent_iteration', 'Iteration', 'iteration_id'
  @belongsTo 'exampleGroup', 'ExampleGroup', 'example_group_id'
  
  @fromJSON: (resources) ->
    return unless resources
    
    resources = JSON.parse(resources) if typeof resources is 'string'
    
    if Spine.isArray(resources)
      (new @(resource['example']) for resource in resources)
    else
      new @(resources['example'])
  
  iteration: ->
    iteration = @parent_iteration()
    iteration = @exampleGroup().iteration() unless iteration? || @exampleGroup() == false
    iteration
  
  project: ->
    iteration().project()
  
  toTree: -> { label: @description }