class Mesh
    constructor: (name, data) ->
        @name = name
        @data = data
        console.log data
        @texture = null
        @material = null
        @transform = new FNX.Transform()
        @

    setMaterial: (material) ->
        material.shader.setUniformMat4 'mTransform', @transform.getTransformation()
        @material = material

    draw: ->
        vertexLocation = gl.getAttribLocation @material.shader.program, 'position'
        normalLocation = gl.getAttribLocation @material.shader.program, 'normal'
        texCoordLocation = gl.getAttribLocation @material.shader.program, 'vertTexCoord'
        samplerLocation = gl.getUniformLocation @material.shader.program, 'Sampler'

        gl.bindBuffer gl.ARRAY_BUFFER, @data.vertexBuffer
        gl.vertexAttribPointer vertexLocation, @data.vertexBuffer.itemSize, gl.FLOAT, gl.FALSE, 0, 0
        gl.enableVertexAttribArray vertexLocation

        gl.bindBuffer gl.ARRAY_BUFFER, @data.normalBuffer
        gl.vertexAttribPointer normalLocation, @data.normalBuffer.itemSize, gl.FLOAT, gl.FALSE, 0, 0
        gl.enableVertexAttribArray normalLocation

        if @material.diffuseTexture
            gl.activeTexture gl.TEXTURE0
            gl.bindTexture gl.TEXTURE_2D, @material.diffuseTexture.texture
            gl.bindBuffer gl.ARRAY_BUFFER, @data.textureBuffer
            gl.vertexAttribPointer texCoordLocation, @data.textureBuffer.itemSize, gl.FLOAT, gl.FALSE, 0, 0
            gl.enableVertexAttribArray texCoordLocation

        gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @data.indexBuffer
        gl.vertexAttribPointer 3, @data.indexBuffer.itemSize, gl.FLOAT, gl.FALSE, 0, 0
        gl.enableVertexAttribArray 3


        gl.drawElements gl.TRIANGLES, @data.indexBuffer.numItems, gl.UNSIGNED_SHORT, 0

module.exports = Mesh