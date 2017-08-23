class Mat4
    m = []
    constructor: ->

    @identity: ->
        @m = []
        @m[i] = (if i % 5 == 0 then 1 else 0) for i in [0 .. 15]

    @translation: (v) ->
        @m = Mat4.identity()
        @m[12] = v.x
        @m[13] = v.y
        @m[14] = v.z
        @m

    get: (x, y) -> @m[x][y]
    set: (x, y, v) -> @m[x][y] = v

    mul: (m) ->
        res = new Mat4()
        for i in [0 .. 3]
            for j in [0 .. 3]
                res.set i, j, @m[i][0] * m.get(0, j) +
                              @m[i][1] * m.get(1, j) +
                              @m[i][2] * m.get(2, j) +
                              @m[i][3] * m.get(3, j)
        res

module.exports = Mat4