Http = require './Http.coffee'

class AssetsManager
    shader_dir: '../res/shaders',

    constructor: ->

    getFile: (url) ->
        new Promise (res, rej) =>
            Http.get url: url, (err, data) =>
                rej err if err
                res data if !err

    loadShader: (name) ->
        new Promise (res, rej) =>
            Promise.all([
                @getFile("#{@shader_dir}/#{name}.vert"),
                @getFile("#{@shader_dir}/#{name}.frag")
            ])
            .then (shaders) =>
                res {vertex: shaders[0], fragment: shaders[1]}
            .catch (err) =>
                rej err

module.exports = AssetsManager