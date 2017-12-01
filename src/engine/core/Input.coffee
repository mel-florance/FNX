EventEmitter = require('events').EventEmitter

class Input extends EventEmitter
    constructor: (@element) ->
        @keys = {}
        @mouse = []
        @wheelDelta = 0
        @mouseDelta = [0, 0];
        @mousePosition = [0, 0];
        @mousePressed = false
        @binded = false
        @init()
        @bind()

    init: ->
        @mouse[i] = null for i in [0 .. 8]
        @element.setAttribute 'tabindex', '0'
        @element.focus()

    pointerLock: ->
        @element.addEventListener 'click', () =>
            @element.requestPointerLock()

    pointerUnlock: ->
        @element.exitPointerLock()

    bind: ->
        @element.addEventListener 'contextmenu', @contextMenu
        window.addEventListener 'keydown', @keydown
        window.addEventListener 'keyup', @keyup
        window.addEventListener 'mousedown', @mousedown
        window.addEventListener 'mouseup', @mouseup
        window.addEventListener 'mousemove', @mousemove
        window.addEventListener 'mousewheel', @mousewheel
        document.addEventListener 'pointerlockchange', @pointerLockChanged, false
        document.addEventListener 'pointerlockerror', @pointerLockError, false
        @binded = true

    unbind: ->
        window.removeEventListener 'keydown', @keydown
        window.removeEventListener 'keyup', @keyup
        window.removeEventListener 'mousedown', @mousedown
        window.removeEventListener 'mouseup', @mouseup
        window.removeEventListener 'mousemove', @mousemove
        window.removeEventListener 'mousewheel', @mousewheel

        @binded = false

    getKey: (code) ->
        @keys[code] is true

    keyup: (e) =>
        if e.target == @element
            delete @keys[e.keyCode]
            @emit 'keyup', e.keyCode

    keydown: (e) =>
        if e.target == @element
            @keys[e.keyCode] = true
            @emit 'keydown', e.keyCode

    mousedown: (e) =>
        if e.target == @element
            @mouse[e.button] = true
            @mousePressed = true
            @emit 'mousedown', e.button

    mouseup: (e) =>
        if e.target == @element
            @mouse[e.button] = false
            @mousePressed = false
            @emit 'mouseup', e.button

    mousemove: (e) =>
        @mouseDelta = [e.movementX - @mousePosition[0], e.movementY - @mousePosition[1]];
        @mousePosition = [e.movementX, e.movementY];
        @emit 'mousemove', @mousePosition, @mouseDelta

    mousewheel: (e) =>
        @wheelDelta = Math.max -1, Math.min(1, (e.wheelDelta || -e.detail))
        @emit 'mousewheel', @wheelDelta

    contextMenu: (e) =>
        e.preventDefault()

    pointerLockChanged: (e) =>
        console.log e

    pointerLockError: (e) =>
        console.log e


module.exports = Input