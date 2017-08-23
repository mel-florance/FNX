Vec3 = require './Vec3.coffee'
Mat4 = require './Mat4.coffee'

class Transform
    constructor: ->
        @translation = new Vec3()

    getTranslation: -> @translation

    getTransformation: ->
        new Mat4.translation @translation

    setTranslation: (x, y, z) ->
        @translation = new Vec3 x, y, z

module.exports = Transform