class Texture
    constructor: (scene, data) ->
        @id = null
        @scene = scene
        @image = data.image
        @name = data.name
        @flipY = true

        @texture = gl.createTexture()
        gl.bindTexture gl.TEXTURE_2D, @texture

        gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, @flipY
        gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE
        gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE
        gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR
        gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR

        gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, data.image
        @id = @scene.addTexture this

module.exports = Texture