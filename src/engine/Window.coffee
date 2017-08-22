GameLoop = require './GameLoop.coffee'

class Window extends GameLoop
    constructor: (container) ->
        super()
        @canvas = window.document.getElementById container
        @size = @canvas.getBoundingClientRect()
        @canvas.width = @size.width
        @canvas.height = @size.height
        window.gl = @canvas.getContext 'webgl' if @canvas

    getWidth: -> @size.width
    getHeight: -> @size.height

module.exports = Window