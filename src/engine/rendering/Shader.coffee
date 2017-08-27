Util = require '../core/Util.coffee'

class Shader
    program: 0
    compiled: false
    uniforms: {}

    # Create a new Shader
    # @return [object] The shader
    constructor: ->
        @program = gl.createProgram()
        console.log 'Shader creation failed' if @program == 0

    # Add a new vertex shader
    # @param [string] The code of the vertex shader
    # @return [void]
    addVertexShader: (str) ->
        @addProgram str, gl.VERTEX_SHADER

    # Add a new fragment shader
    # @param [string] The code of the fragment shader
    # @return [void]
    addFragmentShader : (str) ->
        @addProgram str, gl.FRAGMENT_SHADER

    # Add a new geometry shader
    # @param [string] The code of the geometry shader
    # @return [void]
    addGeometryShader : (str) ->
        @addProgram str, gl.GEOMETRY_SHADER

    # Compile the current shader
    # @return [void] Error if compilation failed
    # @return [true] If the compilation success
    compile: ->
        gl.linkProgram @program
        if !gl.getProgramParameter @program, gl.LINK_STATUS
            console.log gl.getProgramInfoLog @program

        gl.validateProgram @program
        if !gl.getProgramParameter @program, gl.VALIDATE_STATUS
            console.log gl.getProgramInfoLog @program
        else
            @compiled = true

    # Bind the current shader
    # @return [void]
    bind: ->
        gl.useProgram @program

    # Add a new uniform variable to the shader
    # @param [string] name of the uniform
    # @return [integer] The location of the uniform
    addUniform: (name) ->
        location = gl.getUniformLocation @program, name

        if location == -1
            console.log "Shader error: Could not find uniform #{name}"
        else
            @uniforms[name] = location

    # Set the value of a uniform vector 3
    # @param [string] name of the uniform
    # @param [array] value of a vector 3
    # @return [void]
    setUniformVec3: (name, value) ->
        gl.uniform3f @uniforms[name], value[0], value[1], value[2]

    # Set the value of a uniform matrix 4
    # @param [string] name of the uniform
    # @param [Float32Array] value of a matrix 4
    # @return [void]
    setUniformMat4: (name, value) ->
        gl.uniformMatrix4fv @uniforms[name], gl.FALSE, value

    # Set the value of a uniform matrix 4
    # @param [string] name of the uniform
    # @param [integer] value of an integer
    # @return [void]
    setUniformI: (name, value) ->
        gl.uniform1i @uniforms[name], value

    # Set the value of a uniform float value
    # @param [string] name of the uniform
    # @param [float] value of an float
    # @return [void]
    setUniformF: (name, value) ->
        gl.uniform1f @uniforms[name], value

    # Create the shader program
    # @param [string] string code of the shader
    # @param [string] type of the shader to create
    # @return [void]
    addProgram: (str, type) ->
        shader = gl.createShader type
        console.log 'Shader program creation failed' if !shader

        gl.shaderSource shader, str
        gl.compileShader shader

        if !gl.getShaderParameter shader, gl.COMPILE_STATUS
            console.log gl.getShaderInfoLog shader

        gl.attachShader @program, shader

module.exports = Shader