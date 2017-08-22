class Shader
    program: 0
    compiled: false
    uniforms: {}

    constructor: ->
        @program = gl.createProgram()
        console.log 'Shader creation failed' if @program == 0

    addVertexShader   : (str) -> @addProgram str, gl.VERTEX_SHADER
    addFragmentShader : (str) -> @addProgram str, gl.FRAGMENT_SHADER
    addGeometryShader : (str) -> @addProgram str, gl.GEOMETRY_SHADER

    compile: ->
        gl.linkProgram @program
        if !gl.getProgramParameter @program, gl.LINK_STATUS
            console.log gl.getProgramInfoLog @program

        gl.validateProgram @program
        if !gl.getProgramParameter @program, gl.VALIDATE_STATUS
            console.log gl.getProgramInfoLog @program
        else
            @compiled = true

    bind: ->
        gl.useProgram @program

    addUniform: (name) ->
        location = gl.getUniformLocation @program, name

        if location == -1
            console.log "Shader error: Could not find uniform #{name}"

        @uniforms[name] = location

    setUniformVec3: (name, value) ->
        gl.uniform3f @uniforms[name], value.x, value.y, value.z

    setUniformMat4: (name, value) ->
        gl.uniformMatrix4fv @uniforms[name], value.m

    setUniformI: (name, value) ->
        gl.uniform1i @uniforms[name], value

    setUniformF: (name, value) ->
        gl.uniform1f @uniforms[name], value

    addProgram: (str, type) ->
        shader = gl.createShader type
        console.log 'Shader program creation failed' if !shader

        gl.shaderSource shader, str
        gl.compileShader shader

        if !gl.getShaderParameter shader, gl.COMPILE_STATUS
            console.log gl.getShaderInfoLog shader

        gl.attachShader @program, shader

module.exports = Shader