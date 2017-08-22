class Vec2
    constructor: (@x, @y) ->

    length: ->
        Math.sqrt @x * @x + @y * @y

    dot: (v) ->
        @x * v.x + @y * v.y

    cross: (v) ->
        new Vec2 @x * v.y - @y * v.x

    normalize: ->
        len = @length()
        @x /= len
        @y /= len
        @

    rotate: (a) ->
        cos = Math.cos a
        sin = Math.sin a
        new Vec2 x * cos - y * sin, x * sin + y * cos

    add: (v) ->
        new Vec2 @x + v.x, @y + v.y if v instanceof Vec2
        new Vec2 @x + v, @y + v if typeof v == 'Number'

    mul: (v) ->
        new Vec2 @x * v.x, @y * v.y if v instanceof Vec2
        new Vec2 @x * v, @y * v if typeof v == 'Number'

    sub: (v) ->
        new Vec2 @x - v.x, @y - v.y if v instanceof Vec2
        new Vec2 @x - v, @y - v if typeof v == 'Number'

    div: (v) ->
        new Vec2 @x / v.x, @y / v.y if v instanceof Vec2
        new Vec2 @x / v, @y / v if typeof v == 'Number'

module.exports = Vec2