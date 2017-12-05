Light = require './Light.coffee'

module.exports = class DirectionalLight extends Light
    constructor: (scene) ->
        super scene
        @color = FNX.glm.vec3.create()
        @position = FNX.glm.vec3.create()
        @direction = FNX.glm.vec3.create()

