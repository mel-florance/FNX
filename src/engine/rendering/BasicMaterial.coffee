Material = require './Material.coffee'

module.exports = class BasicMaterial extends Material
    constructor: (name, scene) ->
        super name, scene

        @diffuseColor = [1, 1, 1]

        @shader.addUniform 'DiffuseColor'
        @shader.addUniform 'ambientLightIntensity'
        @shader.addUniform 'sun.color'
        @shader.addUniform 'sun.direction'
        @shader.addUniform 'sun.position'
        @shader.addUniform 'alpha'
        @shader.addUniform 'shininess'
        @shader.addUniform 'reflectivity'

        @shader.setUniformVec3 'DiffuseColor', @diffuseColor
        @shader.setUniformVec3 'ambientLightIntensity', scene.ambientColor

        @shader.setUniformVec3 'sun.color', [1.5, 1.5, 1.5]
        @shader.setUniformVec3 'sun.direction', [4, -1, 0]
        @shader.setUniformVec3 'sun.position', [2, 5, 4]

        @shader.setUniformF 'alpha', 1.0
        @shader.setUniformF 'shininess', 50
        @shader.setUniformF 'reflectivity', 0.5

        @
