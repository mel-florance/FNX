var engine = new FNX.Engine('render');
var assets = new FNX.Assets();

Promise.all([
    assets.loadMesh('box'),
    assets.loadShader('basic')
])
.then(data => {
    let mesh = data[0];
    let resource = data[1];

    mesh.shader = new FNX.Shader();
    mesh.shader.addVertexShader(resource.vertex);
    mesh.shader.addFragmentShader(resource.fragment);
    mesh.shader.compile();
    mesh.shader.addUniform('transform');

    let transform = new FNX.Transform();
    transform.setProjection(70, engine.canvas.width, engine.canvas.height, 0.1, 100);
    let t = 0;
    let s = 0;

    engine.run(() => {
        t += engine.deltaTime;
        s = Math.sin(t);

        if(mesh.shader.compiled) {
            transform.translate([s, 0, -5]);
            transform.scale([s, s, s]);
            transform.rotate(s * 2 * Math.PI, [0,1,1]);
            mesh.shader.bind();
            mesh.shader.setUniformMat4('transform', transform.getProjectedTransform());
            mesh.draw();
        }

        if(engine.input.getKey(13))
            console.log('pressed')
    });
});
