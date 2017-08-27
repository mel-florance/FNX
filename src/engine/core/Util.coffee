module.exports =
    createVertexBuffer: (vertices, data = []) ->
        vertices.map (v) ->
            data.push v.position[0], v.position[1], v.position[2]
        new Float32Array data

    createIndicesBuffer: (data) ->
        new Uint16Array data

    createMatrixBuffer: (data) ->
        new Float32Array data