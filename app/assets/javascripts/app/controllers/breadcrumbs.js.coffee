window.BreadcrumbsElement = class BreadcrumbsElement extends Controller
  render: ->
    if @params.client_id? && Client.exists(@params.client_id)
      client = Client.find(@params.client_id)
      
      if @params.project_id? && client?
        project = client.projects().all()[@params.project_id]
        
        if @params.iteration_id? && project?
          iteration = project.iterations().all()[@params.iteration_id] if @params.iteration_id?
          
          if iteration?
            super( client: client, project: project, iteration: iteration )
          else
            super( client: client, project: project )
        else
          super( client: client, project: project )
      else
        super( client: client )
    else
      super()

window.Breadcrumbs = class Breadcrumbs extends Spine.Stack
  controllers:
    clients: BreadcrumbsElement
    projects: BreadcrumbsElement
    iterations: BreadcrumbsElement
    iteration: BreadcrumbsElement