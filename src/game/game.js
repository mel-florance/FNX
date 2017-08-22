var engine = new FNX.Engine('render');

var matrix  = new FNX.Mat4();
var mesh    = new FNX.Mesh();
var assets  = new FNX.Assets();
mesh.shader = new FNX.Shader();

mesh.addVertices([
    new FNX.Vertex(new FNX.Vec3(-1, -1, 0)),
    new FNX.Vertex(new FNX.Vec3(1, -1, 0)),
    new FNX.Vertex(new FNX.Vec3(0, 1, 0))
]);

assets.loadShader('basic').then(resource =>
{
    mesh.shader.addVertexShader(resource.vertex);
    mesh.shader.addFragmentShader(resource.fragment);
    mesh.shader.compile();

    engine.run(() => {
        if(mesh.shader.compiled) {
            mesh.shader.bind();
            mesh.draw();
        }

        if(engine.input.getKey(13))
            console.log('pressed')
    });
})