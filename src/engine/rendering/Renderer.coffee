class Renderer
    constructor: ->
        @

    init: ->
        gl.enable gl.DEPTH_TEST
        gl.cullFace gl.BACK
        gl.enable gl.BLEND
        gl.blendFunc gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA
        gl.enable gl.CULL_FACE
        gl.cullFace gl.BACK

    clear: ->
        gl.clear gl.DEPTH_BUFFER_BIT | gl.COLOR_BUFFER_BIT

    render: (scene) ->
        if scene.activeCamera
            scene.activeCamera.update()

            for material in scene.materials
                material.update()

            for name of scene.meshes
                mesh = scene.meshes[name]
                if mesh.material
                    if mesh.material.shader.compiled
                        mesh.material.shader.setUniformMat4 'mTransform', mesh.transform.getTransformation()
                        mesh.material.shader.setUniformMat4('mView', scene.activeCamera.viewMatrix);
                        mesh.material.shader.setUniformMat4('mProj', scene.activeCamera.projMatrix);
                        mesh.draw()

module.exports = Renderer