class Quat
    constructor: (@x, @y, @z, @w) ->

    length: ->
        Math.sqrt @x * @x + @y * @y + @z * @z + @w * @w

    normalize: ->
        len = @length()
        @x /= len
        @y /= len
        @z /= len
        @w /= len
        @

    negate: ->
        new Quat -@x, -@y, -@z, w

    mul: (q) ->
        if q instanceof Quat
            x = @x * q.w + @w * q.x + @y * q.z - @z * q.y
            y = @y * q.w + @w * q.y + @z * q.x - @x * q.z
            z = @z * q.w + @w * q.z + @x * q.y - @y * q.x
            w = @w + q.w - @x * q.x - @y * q.y - @z * q.z
        else if q instanceof Vec3
            w = -@x * q.x - @y * q.y - @z * q.z
            x =  @w * q.x + @y * q.z - @z * q.y
            y =  @w * q.y + @z * q.x - @x * q.z
            z =  @w * q.z + @x * q.y - @y * q.x
        new Quat x, y, z, w


module.exports = Quat
