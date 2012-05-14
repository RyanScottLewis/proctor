Spine.Controller.include
  view: (name) ->
    JST["app/views/#{name}"]
  
  viewByConvention: (name) ->
    # protoString = @constructor.toString().match(/^function ([^\(]+)/)[1]
    areaName = @constructor.name.replace(/Controller/, '').protoString.underscore()
    JST["app/views/#{areaName}/#{name}"]
  
  generate: (name, data) -> 
    @viewByConvention(name)(data)
  
  htmlify: (name, data) -> @html @generate(name, data)