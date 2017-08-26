Http = require './../network/Http.coffee'

class Assets
    shaders_dir: '../res/shaders',
    models_dir: '../res/models',

    constructor: ->

    getFile: (url) ->
        new Promise (res, rej) =>
            Http.get url: url, (err, data) =>
                rej err if err
                res data if !err

    loadShader: (name) ->
        new Promise (res, rej) =>
            Promise.all([
                @getFile("#{@shaders_dir}/#{name}.vert"),
                @getFile("#{@shaders_dir}/#{name}.frag")
            ])
            .then (shaders) =>
                res {vertex: shaders[0], fragment: shaders[1]}
            .catch (err) =>
                rej err

    loadMesh: (name) ->
        new Promise (res, rej) =>
            @getFile("#{@models_dir}/#{name}.obj").then (data) =>
                vertices = []
                indices = []

                data.split('\n').forEach (line) =>
                    tokens = line.split ' '

                    if tokens[0] == 'v'
                        vertices.push new FNX.Vertex([tokens[1], tokens[2], tokens[3]])
                    else if tokens[0] == 'f'
                        indices.push parseInt(tokens[1]) - 1
                        indices.push parseInt(tokens[2]) - 1
                        indices.push parseInt(tokens[3]) - 1

                mesh = new FNX.Mesh()
                mesh.addVertices vertices, indices
                res mesh

module.exports = Assets