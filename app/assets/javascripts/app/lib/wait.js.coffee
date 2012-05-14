window.wait = (delay, func) -> setTimeout(func, delay)
window.repeat = (delay, func) -> setInterval(func, delay)
window.doAndRepeat = (delay, func) ->
  func()
  setInterval(func, delay)

window.waitUntil = (condition, delay, func) ->
  unless func
    func = delay
    delay = 100
  g = ->
    if condition()
      func()
      clearInterval(h)
  h = setInterval(g, delay)