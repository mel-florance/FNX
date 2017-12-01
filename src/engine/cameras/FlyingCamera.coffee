Camera = require './Camera.coffee'
module.exports = class FlyingCamera extends Camera
    constructor: (scene) ->
        super scene
        @speed = 5
        @pos = FNX.glm.vec3.create()


    update: ->
        factor = @scene.engine.deltaTime * @speed;

        if @keys.up || @keys.down || @keys.left || @keys.right
            @position = FNX.glm.vec3.create()
            @position[2] += factor if @keys.up
            @position[2] -= factor if @keys.down
            @position[0] += factor if @keys.left
            @position[0] -= factor if @keys.right
            @pos = @position
            FNX.glm.mat4.translate @viewMatrix, @viewMatrix, @position
