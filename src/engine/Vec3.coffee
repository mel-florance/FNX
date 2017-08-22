class Vec3
    constructor: (@x, @y, @z) ->

    length: ->
        Math.sqrt @x * @x + @y * @y + @z * @z

    dot: (v) ->
        @x * v.x + @y * v.y + @z * v.z

    cross: (v) ->
        x = @y * v.z - @z * v.y
        y = @z * v.x - @x * v.z
        z = @x * v.y = @y * v.x
        new Vec2 x, y, z

    normalize: ->
        len = @length()
        @x /= len
        @y /= len
        @z /= len

    rotate: (a) ->
        null

    add: (v) ->
        new Vec3 @x + v.x, @y + v.y, @z + v.z if v instanceof Vec3
        new Vec3 @x + v, @y + v, @z + v if typeof v == 'Number'

    mul: (v) ->
        new Vec3 @x * v.x, @y * v.y, @z * v.z if v instanceof Vec3
        new Vec3 @x * v, @y * v, @z * v if typeof v == 'Number'

    sub: (v) ->
        new Vec3 @x - v.x, @y - v.y, @z - v.z if v instanceof Vec3
        new Vec3 @x - v, @y - v, @z - v if typeof v == 'Number'

    div: (v) ->
        new Vec3 @x / v.x, @y / v.y, @z / v.z if v instanceof Vec3
        new Vec3 @x / v, @y / v, @z / v if typeof v == 'Number'

module.exports = Vec3