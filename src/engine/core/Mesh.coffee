Vertex = require './Vertex.coffee'
Util = require './Util.coffee'

class Mesh
    size: 0
    vbo: 0

    constructor: ->
        @vbo = gl.createBuffer()

    addVertices: (vertices) ->
        @size = vertices.length
        buffer = Util.createVertexBuffer vertices
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.bufferData gl.ARRAY_BUFFER, buffer, gl.STATIC_DRAW

    draw: ->
        gl.enableVertexAttribArray 0
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.vertexAttribPointer 0, 3, gl.FLOAT, gl.FALSE, @size * Vertex.SIZE, 0
        gl.drawArrays gl.TRIANGLES, 0, 3

module.exports = Mesh