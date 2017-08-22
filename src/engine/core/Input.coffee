class Input
    constructor: (@element) ->
        @keys = []
        @mouse = []
        @mousePressed = false
        @init()

    init: ->
        @keys[i] = false for i in [0 .. 255]
        @mouse[i] = false for i in [0 .. 8]
        @element.setAttribute 'tabindex', '0'
        @element.focus()
        window.addEventListener 'keydown', @keydown
        window.addEventListener 'keyup', @keyup
        window.addEventListener 'mousedown', @mousedown
        window.addEventListener 'mouseup', @mouseup

    getKey: (code) ->
        @keys[code] is true

    keyup: (e) =>
        if e.target == @element
            @keys[e.keyCode] = false

    keydown: (e) =>
        if e.target == @element
            @keys[e.keyCode] = true

    mousedown: (e) =>
        if e.target == @element
            @mouse[e.button] = true
            @mousePressed = true

    mouseup: (e) =>
        if e.target == @element
            @mouse[e.button] = false
            @mousePressed = false

module.exports = Input