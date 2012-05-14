window.ExampleGroup = class ExampleGroup extends Spine.Model
  @configure "ExampleGroup", "description", "created_at", "updated_at"
  @extend Spine.Model.Ajax
  @url: "/example_groups"
  @belongsTo 'parent_iteration', 'Iteration', 'iteration_id'
  @belongsTo 'exampleGroup', 'ExampleGroup', 'example_group_id'
  @hasMany 'examples', 'Example'
  @hasMany 'exampleGroups', 'ExampleGroup'
  
  @fromJSON: (resources) ->
    return unless resources
    
    if typeof resources is 'string'
      resources = JSON.parse(resources)
    
    if Spine.isArray(resources)
      (new @(resource['example_group']) for resource in resources)
    else
      new @(resources['example_group'])
  
  iteration: ->
    iteration = @parent_iteration()
    iteration = @exampleGroup().iteration() unless iteration? || @exampleGroup() == false
    iteration
  
  project: ->
    iteration().project()
  
  toTree: ->
    tree = { label: @description }
    
    children = []
    
    unless @examples().all().length == 0
      examples = @examples().all().map (example) -> example.toTree()
      children = children.concat(examples)
      
    unless @exampleGroups().all().length == 0
      exampleGroups = @exampleGroups().all().map (exampleGroup) -> exampleGroup.toTree()
      children = children.concat(exampleGroups)
    
    # children = _.sortBy children, (example) -> example.created_at # TODO: MAY NOT BE NEEDED
    
    unless children.length == 0
      tree.children = children
    
    tree