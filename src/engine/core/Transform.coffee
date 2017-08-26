glm = require 'gl-matrix'

class Transform
    zNear: 0.01,
    zFar: 1000,
    width: 0,
    height: 0,
    fov: 70

    constructor: ->
        @identity = glm.mat4.identity new Float32Array(16)
        @translation = glm.mat4.identity new Float32Array(16)
        @rotation = glm.mat4.identity new Float32Array(16)
        @scaling = glm.mat4.identity new Float32Array(16)

    getTransformation: ->
       r = glm.mat4.identity new Float32Array(16)
       glm.mat4.mul r, @scaling, r
       glm.mat4.mul r, @rotation, r
       glm.mat4.mul r, @translation, r

    getProjectedTransform: ->
        res = glm.mat4.identity new Float32Array(16)
        proj = glm.mat4.identity new Float32Array(16)
        glm.mat4.perspective proj, @fov, @width / @height, @zNear, @zFar
        transform = @getTransformation()
        glm.mat4.mul res, proj, transform

    setProjection: (fov, width, height, zNear, zFar)->
        @fov = fov
        @width = width
        @height = height
        @zNear = zNear
        @zFar = zFar

    translate: (v = [0, 0, 0]) ->
        glm.mat4.translate @translation, @identity, v

    rotate: (angle, axes = [1, 1, 1]) ->
        glm.mat4.rotate @rotation, @identity, angle, axes

    scale: (scale = [1, 1, 1]) ->
        glm.mat4.scale @scaling, @identity, scale

module.exports = Transform