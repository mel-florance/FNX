class GameLoop
    constructor: ->
        @running = false
        @lastFrameTime = Date.now()
        @deltaTime = 0
        @fps = 0
        @fpsDelay = 1000
        @loopId = 0

    loop: (cb) ->
        frame = => @loop cb
        if !@lastFrameTime
            @lastFrameTime = Date.now()
            @loopId = window.requestAnimationFrame frame
            return

        @deltaTime = (Date.now() - @lastFrameTime) / 1000
        @lastFrameTime = Date.now()

        @update() if typeof @update == 'function'
        cb() if typeof cb == 'function'

        @loopId = window.requestAnimationFrame frame if @running

    run: (cb) ->
        @running = true
        @loop cb

        window.setInterval =>
            @fps = Math.floor 1 / @deltaTime
        , @fpsDelay

module.exports = GameLoop