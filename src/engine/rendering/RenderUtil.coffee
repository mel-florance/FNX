module.exports =
    clearScreen: ->
        gl.clear gl.DEPTH_BUFFER_BIT | gl.COLOR_BUFFER_BIT

    initGraphics: ->
        gl.clearColor 0, 0, 0, 1
        gl.enable gl.DEPTH_TEST
        gl.cullFace gl.BACK
        gl.frontFace gl.CCW