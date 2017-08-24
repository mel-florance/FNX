Vec3 = require './Vec3.coffee'
Mat4 = require './Mat4.coffee'

class Transform
    constructor: ->
        @translation = new Vec3()
        @rotation = new Vec3()

    getTranslation: -> @translation
    getRotation: -> @rotation

    getTransformation: ->
        translation = new Mat4.translation @translation
        rotation = new Mat4.rotation @rotation
        return translation.mul rotation

    setTranslation: (x, y, z) ->
        @translation = new Vec3 x, y, z

    setRotation: (x, y, z) ->
        @rotation = new Vec3 x, y, z

module.exports = Transform