Window = require './../rendering/Window.coffee'
Input = require './Input.coffee'
Renderer = require './../rendering/Renderer.coffee'

class Engine extends Window
    constructor: (container) ->
        super container
        @renderer = new Renderer()
        @input = new Input @canvas
        @renderer.init()
        @scenes = []
        @activeScene = null

    addScene: (scene) ->
        @scenes.push scene
        @activeScene = @scenes.length - 1

    render: ->
        @renderer.clear()
        @scenes.forEach (scene, index) =>
            if @activeScene == index
                @renderer.render @scenes[index]

module.exports = Engine