glm = require 'gl-matrix'

class Vertex
    SIZE: 4
    texCoords: glm.vec2.fromValues 0, 0
    constructor: (@position, @texCoords) ->

module.exports = Vertex