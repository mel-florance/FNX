Http = require './../network/Http.coffee'

class Assets
    textures: {},

    shaders_dir: '../res/shaders',
    textures_dir: '../res/textures',
    models_dir: '../res/models',

    constructor: (scene) ->
        @scene = scene

    getFile: (url) ->
        new Promise (res, rej) =>
            Http.get url: url, (err, data) =>
                rej err if err
                res data if !err

    loadImage: (img) ->
        new Promise (res) =>
            image = new Image()
            image.src = "#{@textures_dir}/#{img}"
            image.onload = =>
                @textures[img] = {name: img, image: image}
                res @textures[img]

    loadShader: (name) ->
        new Promise (res, rej) =>
            Promise.all([
                @getFile("#{@shaders_dir}/#{name}.vert"),
                @getFile("#{@shaders_dir}/#{name}.frag")
            ])
            .then (shaders) =>
                shader = {vertex: shaders[0], fragment: shaders[1]}
                @scene.shaders[name] = shader
                res shader
            .catch (err) =>
                rej err

    loadMesh: (name) ->
        new Promise (res, rej) =>
            @getFile("#{@models_dir}/#{name}.obj").then (data) =>
                parsed = new FNX.OBJ.Mesh data
                FNX.OBJ.initMeshBuffers gl, parsed
                mesh = new FNX.Mesh name, parsed
                @scene.meshes[name] = mesh
                res mesh

module.exports = Assets