Vertex = require './Vertex.coffee'
Util = require './Util.coffee'

class Mesh
    verticesSize: 0
    indicesSize: 0
    vbo: 0
    ibo: 0

    constructor: ->
        @vbo = gl.createBuffer()
        @ibo = gl.createBuffer()

    addVertices: (vertices, indices = []) ->
        @verticesSize = vertices.length
        @indicesSize = indices.length
        vertexBuffer = Util.createVertexBuffer vertices
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.bufferData gl.ARRAY_BUFFER, vertexBuffer, gl.STATIC_DRAW

        indicesBuffer = Util.createIndicesBuffer indices
        gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @ibo
        gl.bufferData gl.ELEMENT_ARRAY_BUFFER, indicesBuffer, gl.STATIC_DRAW
        @

    draw: ->
        gl.enableVertexAttribArray 0
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.vertexAttribPointer 0, 3, gl.FLOAT, gl.FALSE, @verticesSize * Vertex.SIZE, 0

        gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @ibo
        gl.drawElements gl.TRIANGLES, @indicesSize, gl.UNSIGNED_SHORT, 0

        gl.disableVertexAttribArray 0

module.exports = Mesh