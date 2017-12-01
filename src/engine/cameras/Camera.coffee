class Camera
    constructor: (scene) ->
        @scene = scene
        @fov = FNX.glm.glMatrix.toRadian 35
        @ratio = @scene.engine.canvas.clientWidth / @scene.engine.canvas.clientHeight
        @near = 0.1
        @far = 100
        @keys =
            up: false
            down: false
            left: false
            right: false

        @angles = FNX.glm.vec3.create()
        @identity = FNX.glm.mat4.create();
        @worldMatrix = FNX.glm.mat4.create();
        @viewMatrix = FNX.glm.mat4.create();
        @projMatrix = FNX.glm.mat4.create()

        FNX.glm.mat4.perspective @projMatrix, @fov, @ratio, @near, @far

        @scene.engine.input.on 'keydown', (key) =>
            @keys.up = true if key == 90
            @keys.down = true if key == 83
            @keys.left = true if key == 81
            @keys.right = true if key == 68

        @scene.engine.input.on 'keyup', (key) =>
            @keys.up = false if key == 90
            @keys.down = false if key == 83
            @keys.left = false if key == 81
            @keys.right = false if key == 68

        @scene.engine.input.on 'mousewheel', (delta) =>
            @fov -= delta * @scene.engine.deltaTime;
            FNX.glm.mat4.perspective @projMatrix, @fov, @ratio, @near, @far

        @scene.engine.input.on 'mousemove', (pos, delta) =>
            @angles[0] += delta[0] * 0.1 * @scene.engine.deltaTime;
            @angles[1] += delta[1] * 0.1 * @scene.engine.deltaTime;
            FNX.glm.mat4.rotateY @viewMatrix, @viewMatrix, @angles[0]
            FNX.glm.mat4.rotateX @viewMatrix, @viewMatrix, @angles[1]

        @scene.engine.scenes[@scene.engine.activeScene].activeCamera = this

module.exports = Camera