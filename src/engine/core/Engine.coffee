Window = require './../rendering/Window.coffee'
Input = require './Input.coffee'
RenderUtil = require './../rendering/RenderUtil.coffee'

class Engine extends Window
    constructor: (container) ->
        super container
        @input = new Input @canvas
        RenderUtil.initGraphics()

    update: ->
        RenderUtil.clearScreen()

module.exports = Engine