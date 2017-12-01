GameLoop = require './../core/GameLoop.coffee'

class Window extends GameLoop

    # Create a new surface to draw in a WebGL context.
    # @param [string] The id of the dom element without the hash
    # @return [object] The WebGL context
    constructor: (container) ->
        super()
        @canvas = window.document.getElementById container

        if @canvas
            window.gl = @canvas.getContext 'webgl2'
            @computeArea();
            window.addEventListener 'resize', (event) =>
                @computeArea();

    # Compute the area of the current canvas
    computeArea: ->
        @size = @canvas.parentNode.getBoundingClientRect()
        @canvas.width = @size.width
        @canvas.height = @size.height
        window.gl.viewport 0, 0, @size.width, @size.height

    # Get the width of the canvas
    # @return [Integer] The width in pixels
    getWidth: ->
        @size.width

    # Get the height of the canvas
    # @return [Integer] The height in pixels
    getHeight: ->
        @size.height

module.exports = Window