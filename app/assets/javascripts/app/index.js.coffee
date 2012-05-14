#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/relation
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

window.Proctor = class Proctor extends Controller
  initialize: ->
    @routes
      '/clients'                                                          : @clients
      '/clients/:client_id'                                               : @projects
      '/clients/:client_id/projects/:project_id'                          : @iterations
      '/clients/:client_id/projects/:project_id/iterations/:iteration_id' : @iteration
    
    @stacks = 
      navigation:  new Navigation( el: $('#navigation') )
      breadcrumbs: new Breadcrumbs( el: $('#breadcrumbs') )
      content:     new Content( el: $('#content') )
    
    @client = new Faye.Client('http://localhost:3000/faye');
    
    
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    # 
    # @client.subscribe "/resources", (message) -> Spine.Ajax.disable ->
    #   
    #   
    #   try 
    #     resource = window[message.resource]
    #   catch error
    #     console.log "Could not find resource: #{message.resource}"
    #     return false
    #   
    #   switch message.action
    #     when 'create' then resource.create(message.data)
    #     when 'update'
    #       if attributes.client_id?
    #         client_id = attributes.client_id
    #         delete attributes.client_id
    #         
    #         Client.find(client_id).projects().create(attributes)
    #       else
    #         Project.create(attributes)
    #     when 'destroy' then resource.destroy(message.data)
    #     else
    #       console.log "Could not find action: #{message.action}"
    #       return false
    # 
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    # !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!! !!!! TESTING AREA !!!!
    
    
    @client.subscribe "/clients/create", (attributes) -> Spine.Ajax.disable -> Client.create(attributes)
    @client.subscribe "/clients/update", (attributes) -> Spine.Ajax.disable -> Client.find(attributes.id).updateAttributes(attributes)
    @client.subscribe "/clients/destroy", (id) -> Spine.Ajax.disable -> Client.destroy(id)
    
    @client.subscribe "/projects/create", (attributes) -> Spine.Ajax.disable ->
      if attributes.client_id?
        client_id = attributes.client_id
        delete attributes.client_id
        
        Client.find(client_id).projects().create(attributes)
      else
        Project.create(attributes)
    @client.subscribe "/projects/update", (attributes) -> Spine.Ajax.disable -> Project.find(attributes.id).updateAttributes(attributes)
    @client.subscribe "/projects/destroy", (id) -> Spine.Ajax.disable -> Project.destroy(id)
    
    @client.subscribe "/iterations/create", (attributes) -> Spine.Ajax.disable ->
      if attributes.project_id?
        project_id = attributes.project_id
        delete attributes.project_id
        
        Project.find(project_id).iterations().create(attributes)
      else
        Iteration.create(attributes)
    @client.subscribe "/iterations/update", (attributes) -> Spine.Ajax.disable -> Iteration.find(attributes.id).updateAttributes(attributes)
    @client.subscribe "/iterations/destroy", (id) -> Spine.Ajax.disable -> Iteration.destroy(id)
    
    @client.subscribe "/example_groups/create", (attributes) -> Spine.Ajax.disable ->
      if attributes.iteration_id?
        iteration_id = attributes.iteration_id
        delete attributes.iteration_id
        
        Iteration.find(iteration_id).exampleGroups().create(attributes)
      else if attributes.example_group_id?
        example_group_id = attributes.example_group_id
        delete attributes.example_group_id
        
        parent_example_group = ExampleGroup.find(example_group_id)
        example_group = parent_example_group.exampleGroups().create(attributes)
      else
        ExampleGroup.create(attributes)
    @client.subscribe "/example_groups/update", (attributes) -> Spine.Ajax.disable -> ExampleGroup.find(attributes.id).updateAttributes(attributes)
    @client.subscribe "/example_groups/destroy", (id) -> Spine.Ajax.disable -> ExampleGroup.destroy(id)
    
    @client.subscribe "/examples/create", (attributes) -> Spine.Ajax.disable ->
      if attributes.example_group_id?
        example_group_id = attributes.example_group_id
        delete attributes.example_group_id
        
        ExampleGroup.find(example_group_id).examples().create(attributes)
      else
        Example.create(attributes)
    @client.subscribe "/examples/update", (attributes) -> Spine.Ajax.disable -> Example.find(attributes.id).updateAttributes(attributes)
    @client.subscribe "/examples/destroy", (id) -> Spine.Ajax.disable -> Example.destroy(id)
    
    # TODO: Users should not need to wait until models are bootstrapped. Ever!
    
    Client.fetch()
    Client.one 'refresh', ->
      Project.fetch()
      Project.one 'refresh', ->
        Iteration.fetch()
        Iteration.one 'refresh', ->
          ExampleGroup.fetch()
          ExampleGroup.one 'refresh', ->
            Example.fetch()
            Example.one 'refresh', ->
              Spine.Route.setup()
  
  clients: (params) -> stack.clients.active(params) for name, stack of @stacks
  projects: (params) -> stack.projects.active(params) for name, stack of @stacks
  iterations: (params) -> stack.iterations.active(params) for name, stack of @stacks
  iteration: (params) -> stack.iteration.active(params) for name, stack of @stacks
