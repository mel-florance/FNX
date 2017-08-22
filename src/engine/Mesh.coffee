Vertex = require './Vertex.coffee'

class Mesh
    size: 0
    vbo: 0

    constructor: ->
        @vbo = gl.createBuffer()

    createVertexBuffer: (vertices, data = []) ->
        vertices.map (v) =>
            data.push v.position.x
            data.push v.position.y
            data.push v.position.z
        new Float32Array data

    addVertices: (vertices) ->
        @size = vertices.length
        buffer = @createVertexBuffer vertices
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.bufferData gl.ARRAY_BUFFER, buffer, gl.STATIC_DRAW

    draw: ->
        gl.enableVertexAttribArray 0
        gl.bindBuffer gl.ARRAY_BUFFER, @vbo
        gl.vertexAttribPointer 0, 3, gl.FLOAT, gl.FALSE, @size * Vertex.SIZE, 0
        gl.drawArrays gl.TRIANGLES, 0, 3

module.exports = Mesh