class Mat4
    constructor: (@m = []) ->
        @m[i] = 0 for i in [0 .. 15]
        return @

    @identity: ->
        m = new Mat4()
        m.m[i] = (if i % 5 == 0 then 1 else 0) for i in [0 .. 15]
        m

    @translation: (v) ->
        m = new Mat4()
        m.m[i] = (if i % 5 == 0 then 1 else 0) for i in [0 .. 15]
        m.m[12] = v.x
        m.m[13] = v.y
        m.m[14] = v.z
        m

    @rotation: (v) ->
        rx = Mat4.identity()
        ry = Mat4.identity()
        rz = Mat4.identity()

        rx.m[5] = Math.cos v.x
        rx.m[6] = -Math.sin v.x
        rx.m[9] = Math.sin v.x
        rx.m[10] = Math.cos v.x

        ry.m[0] = Math.cos v.y
        ry.m[2] = -Math.sin v.y
        ry.m[8] = Math.sin v.y
        ry.m[10] = Math.cos v.y

        rz.m[0] = Math.cos v.z
        rz.m[1] = -Math.sin v.z
        rz.m[4] = Math.sin v.z
        rz.m[5] = Math.cos v.z

        rz.mul(ry.mul(rx))

    get: (x, y) ->
        @m[x][y]

    set: (x, y, v) ->
        @m[x][y] = v

    mul: (m) ->
        n = null
        i = 0
        while i < m.length / 3
            j = 0
            while j < 3
                n = 0
                k = 0
                while k < 3
                    n += @m[3 * j + k] * m[3 * i + k]
                    k++
                m[3 * i + j] = n
                j++
            i++
        return m

module.exports = Mat4