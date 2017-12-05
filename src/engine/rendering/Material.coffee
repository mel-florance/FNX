module.exports = class Material
    constructor: (name, scene) ->
        @name = name
        @scene = scene

        @diffuseTexture = null
        @diffuseColor = null

        @shader = new FNX.Shader()
        @shader.addVertexShader scene.shaders.basic.vertex
        @shader.addFragmentShader scene.shaders.basic.fragment

        @shader.compile()
        @shader.bind()

        @shader.addUniform 'mView'
        @shader.addUniform 'mViewInverse'
        @shader.addUniform 'mProj'
        @shader.addUniform 'mTransform'

        if @scene.activeCamera
            @shader.setUniformMat4 'mView', @scene.activeCamera.viewMatrix
            @shader.setUniformMat4 'mViewInverse', FNX.glm.mat4.invert(@scene.activeCamera.viewMatrix, @scene.activeCamera.viewMatrix)
            @shader.setUniformMat4 'mProj', @scene.activeCamera.projMatrix

        @scene.materials.push(this)

    setDiffuseTexture: (texture) ->
        @diffuseTexture = texture

    update: ->
        if @scene.activeCamera
            return
#            @shader.setUniformMat4 'mView', @scene.activeCamera.viewMatrix
#            @shader.setUniformMat4 'mViewInverse', FNX.glm.mat4.invert(@scene.activeCamera.viewMatrix, @scene.activeCamera.viewMatrix)
