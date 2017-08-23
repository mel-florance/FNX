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
    mesh.shader.addUniform('transform');

    let transform = new FNX.Transform();
    let t = 0;

    engine.run(() => {
        t += engine.deltaTime;

        if(mesh.shader.compiled) {
            mesh.shader.bind();
            transform.setTranslation(Math.sin(t), Math.cos(t), 0);
            mesh.shader.setUniformMat4('transform', transform.getTransformation());
            mesh.draw();
        }

        if(engine.input.getKey(13))
            console.log('pressed')
    });
});