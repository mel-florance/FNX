class Camera
    constructor: (scene) ->
        @scene = scene
        @fov = 35
        @ratio = @scene.engine.canvas.clientWidth / @scene.engine.canvas.clientHeight
        @near = 0.1
        @far = 100
        @keys =
            up: false
            down: false
            left: false
            right: false

        @identity = FNX.glm.mat4.create()
        @worldMatrix = FNX.glm.mat4.create()
        @viewMatrix = FNX.glm.mat4.create()
        @projMatrix = FNX.glm.mat4.create()

        FNX.glm.mat4.perspective @projMatrix, FNX.glm.glMatrix.toRadian(@fov), @ratio, @near, @far

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

        @scene.engine.scenes[@scene.engine.activeScene].activeCamera = this

module.exports = Camera