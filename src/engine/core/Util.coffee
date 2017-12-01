module.exports =
    createBuffer: (type, data, size) ->
        buffer = gl.createBuffer()
        arrayType = if type == gl.ARRAY_BUFFER then Float32Array else Uint16Array
        gl.bindBuffer type, buffer
        gl.bufferData type, new arrayType(data), gl.STATIC_DRAW
        buffer.itemSize = size
        buffer.numItems = data.length / size
        buffer

    createVertexBuffer: (vertices, data = []) ->
        new Float32Array vertices

    createIndicesBuffer: (data) ->
        new Uint16Array data

    createMatrixBuffer: (data) ->
        new Float32Array data