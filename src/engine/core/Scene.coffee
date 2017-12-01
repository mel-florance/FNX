class Scene
    constructor: (name, engine) ->
        @name = name
        @engine = engine
        @meshes = {}
        @shaders = {}
        @materials = []
        @textures = {}
        @activeCamera = null

        @ambientColor = [0.15, 0.15, 0.15];

        @texturesIndex = -1

        @setClearColor()
        @engine.addScene this

        @

    setClearColor: (r = .2, g = .2, b = .2, a = 0) ->
        gl.clearColor r, g, b, a

    addTexture: (texture) ->
        @textures[name] = texture;
        @texturesIndex++

    getMeshByName: (name) ->
        for mesh of @meshes
            if mesh == name
                return @meshes[name]

module.exports = Scene
