window.NavigationClients = class NavigationClients extends Controller
  className: 'clients'
  initialize: -> Client.bind('refresh change', @render)
  render: -> super( clients: Client.all() )

window.NavigationProjects = class NavigationProjects extends Controller
  className: 'projects'
  initialize: -> Project.bind('refresh change', @render)
  render: ->
    if Client.exists(@params.client_id)
      projects = Client.find(@params.client_id).projects().all()
      
      super( projects: projects )
    else
      @navigate('/clients')

window.NavigationIterations = class NavigationIterations extends Controller
  className: 'iterations'
  initialize: -> Iteration.bind('refresh change', (resource) => @render(resource))
  render: (resource) =>
    if @params? && @params.client_id?
      if Client.exists(@params.client_id) && @params.project_id?
        project = Client.find(@params.client_id).projects().all()[@params.project_id]
        
        if project?
          super( iterations: project.iterations().all() )
        else
          @navigate("/clients/#{@params.client_id}")
      else
        @navigate("/clients")

window.Navigation = class Navigation extends Spine.Stack
  controllers:
    clients: NavigationClients
    projects: NavigationProjects
    iterations: NavigationIterations
    iteration: NavigationIterations