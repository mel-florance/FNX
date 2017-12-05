Camera = require './Camera.coffee'

module.exports = class FlyingCamera extends Camera
    constructor: (scene, opts = {}) ->
        super scene

        @wheelSensitivity = 50
        @position = opts.position or FNX.glm.vec3.create()
        @rotation = opts.rotation or FNX.glm.vec3.create()
        @positionSpeed = opts.positionSpeed or 10
        @rotationSpeed = opts.rotationSpeed or .1

        @camera = FNX.glm.mat4.create()
        @cameraMat = FNX.glm.mat4.create()

        @mouse = FNX.glm.vec2.create()

        @scene.engine.input.on 'mousewheel', (delta) =>
            @fov -= delta * @wheelSensitivity * @scene.engine.deltaTime;
            FNX.glm.mat4.perspective @projMatrix, FNX.glm.glMatrix.toRadian(@fov), @ratio, @near, @far

        @scene.engine.input.on 'mousemove', (pos, delta) =>
            @mouse[0] += delta[0]
            @mouse[1] += delta[1]

            PI_TWO = Math.PI * 2
            H_PI = Math.PI * 0.5

            @rotation[1] += FNX.glm.glMatrix.toRadian(@mouse[0]) * @rotationSpeed
            if(@rotation[1] < 0)
                @rotation[1] += PI_TWO
            if(@rotation[1] >= PI_TWO)
                @rotation[1] -= PI_TWO

            @rotation[0] += FNX.glm.glMatrix.toRadian(@mouse[1]) * @rotationSpeed
            if(@rotation[0] < -H_PI)
                @rotation[0] = -H_PI
            if(@rotation[0] > H_PI)
                @rotation[0] = H_PI

    multiplyVec3: (a, b, c) ->
        c or (c = b)
        d = b[0]
        e = b[1]
        b = b[2]
        c[0] = a[0] * d + a[4] * e + a[8] * b + a[12]
        c[1] = a[1] * d + a[5] * e + a[9] * b + a[13]
        c[2] = a[2] * d + a[6] * e + a[10] * b + a[14]
        c

    update: ->
        dir = FNX.glm.vec4.create()
        speed = @positionSpeed * @scene.engine.deltaTime
        dir[2] += speed if @keys.up
        dir[2] -= speed if @keys.down
        dir[0] += speed if @keys.left
        dir[0] -= speed if @keys.right

        FNX.glm.mat4.identity(@viewMatrix);
        FNX.glm.mat4.rotateX(@viewMatrix, @viewMatrix, @rotation[0]);
        FNX.glm.mat4.rotateY(@viewMatrix, @viewMatrix, @rotation[1]);
        FNX.glm.mat4.invert(@viewMatrix, @viewMatrix)

        @multiplyVec3(@viewMatrix, dir);
        FNX.glm.vec3.add(@position, @position, dir);

        FNX.glm.mat4.identity(@viewMatrix);
        FNX.glm.mat4.rotateX(@viewMatrix, @viewMatrix, @rotation[0]);
        FNX.glm.mat4.rotateY(@viewMatrix, @viewMatrix, @rotation[1]);
        FNX.glm.mat4.translate(@viewMatrix, @viewMatrix, @position);

