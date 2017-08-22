Window = require './Window.coffee'
Input = require './Input.coffee'
RenderUtil = require './RenderUtil.coffee'

class Engine extends Window
    constructor: (container) ->
        super container
        @input = new Input @canvas
        RenderUtil.initGraphics()

    update: ->
        RenderUtil.clearScreen()

module.exports = Engine