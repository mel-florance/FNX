module.exports =
    createVertexBuffer: (vertices, data = []) ->
        vertices.map (v) =>
            data.push v.position.x
            data.push v.position.y
            data.push v.position.z
        new Float32Array data

    createMatrixBuffer: (data) ->
        new Float32Array data