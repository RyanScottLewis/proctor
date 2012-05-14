window.Controller = class Controller extends Spine.Controller
  constructor: ->
    super
    @initialize() if @initialize? && typeof @initialize == 'function'
    @viewPath = @constructor.name.underscore().replace(/_/, '/')
    @params ||= {}
  
  activate: (params) ->
    super
    @params = params
    @render() if @render? && typeof @render == 'function'
  
  template: -> @view(@viewPath)
  render: (locals) =>
    locals ||= {}
    @html @template()( $.extend({}, { params: @params }, locals) )