glm = require 'gl-matrix'

class Camera
    yAxis: glm.vec3.create [0, 1, 0]
    position: glm.vec3.create [0, 0, 0]
    forward:glm.vec3.create [0, 0, -1]
    up: glm.vec3.create [0, 1, 0]

    constructor: ->

    move: (dir, value) ->
        @position = @position.add dir.mul(value)

    rotateX: (angle) ->
        hAxis = @yAxis.cross @forward
        hAxis.normalize()

        @forward.rotate()

    getLeft: ->
        @up.cross(@forward).normalize()

    getRight: ->
        @forward.cross(@up).normalize()


module.exports = Camera