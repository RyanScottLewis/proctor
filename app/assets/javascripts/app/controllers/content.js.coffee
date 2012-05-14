window.ContentClients = class ContentClients extends Controller
  className: 'clients'
  
  initialize: ->
    Client.bind('refresh change', @render)
    Project.bind('refresh change', @render)
    Iteration.bind('refresh change', @render)
    ExampleGroup.bind('refresh change', @render)
    Example.bind('refresh change', @render)
  
  render: -> super( clients: Client.all() )

window.ContentProjects = class ContentProjects extends Controller
  className: 'projects'
  
  initialize: ->
    Client.bind('refresh change', @render)
    Project.bind('refresh change', @render)
    Iteration.bind('refresh change', @render)
    ExampleGroup.bind('refresh change', @render)
    Example.bind('refresh change', @render)
  
  render: ->
    if Client.exists(@params.client_id)
      projects = Client.find(@params.client_id).projects().all()
      super( projects: projects, params: @params )
    else
      @navigate('/clients')

window.ContentIterations = class ContentIterations extends Controller
  className: 'iterations'
  
  initialize: ->
      Client.bind('refresh change', (resource) => @render(resource))
      Project.bind('refresh change', (resource) => @render(resource))
      Iteration.bind('refresh change', (resource) => @render(resource))
      ExampleGroup.bind('refresh change', (resource) => @render(resource))
      Example.bind('refresh change', (resource) => @render(resource))
  
  render: (resource) =>
    if @params? && @params.client_id?
      if Client.exists(@params.client_id) && @params.project_id?
        project = Client.find(@params.client_id).projects().all()[@params.project_id]
        
        if project?
          super( iterations: project.iterations().all(), params: @params )
        else
          @navigate("/clients/#{@params.client_id}")
      else
        @navigate("/clients")

window.ContentIteration = class ContentIteration extends Controller
  className: 'iteration'
  
  initialize: ->
    Client.bind('refresh change', (resource) => @render(resource))
    Project.bind('refresh change', (resource) => @render(resource))
    Iteration.bind('refresh change', (resource) => @render(resource))
    ExampleGroup.bind('refresh change', (resource) => @render(resource))
    Example.bind('refresh change', (resource) => @render(resource))
  
  render: (resource) =>
    if @params? && @params.client_id?
      if Client.exists(@params.client_id)
        project = Client.find(@params.client_id).projects().all()[@params.project_id]
        
        if project?
          iteration = project.iterations().all()[@params.iteration_id]
          
          if iteration?
            super(iteration: iteration, params: @params)
            # @$('.tree').tree( data: iteration.toTree(), saveState: "iterations/#{iteration.id}", autoOpen: 2 )
            @$('.tree').tree( data: iteration.toTree(), autoOpen: 2 )
          else
            @navigate("/clients/#{@params.client_id}/projects/#{@params.project_id}")
        else
          @navigate("/clients/#{@params.client_id}")
      else
        @navigate("/clients")

window.Content = class Content extends Spine.Stack
  controllers:
    clients: ContentClients
    projects: ContentProjects
    iterations: ContentIterations
    iteration: ContentIteration