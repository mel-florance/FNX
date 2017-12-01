module.exports = class Transform
    constructor: () ->
        @identity = FNX.glm.mat4.create()
        @translation = FNX.glm.mat4.create()
        @rotation = FNX.glm.mat4.create()
        @scaling = FNX.glm.mat4.create()

    getTransformation: ->
        transform = FNX.glm.mat4.create()
        FNX.glm.mat4.mul transform, @scaling, transform
        FNX.glm.mat4.mul transform, @rotation, transform
        FNX.glm.mat4.mul transform, @translation, transform

    translate: (direction = [0, 0, 0]) ->
        FNX.glm.mat4.translate @translation, @identity, direction

    rotate: (angle, axes = [1, 1, 1]) ->
        FNX.glm.mat4.rotate @rotation, @identity, angle, axes

    scale: (scale = [1, 1, 1]) ->
        FNX.glm.mat4.scale @scaling, @identity, scale