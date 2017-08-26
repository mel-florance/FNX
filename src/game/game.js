var engine = new FNX.Engine('render');

var assets = new FNX.Assets();


assets.loadMesh('box').then(mesh =>
{
    mesh.shader = new FNX.Shader();
    assets.loadShader('basic').then(resource =>
    {
        mesh.shader.addVertexShader(resource.vertex);
        mesh.shader.addFragmentShader(resource.fragment);
        mesh.shader.compile();
        mesh.shader.addUniform('transform');

        let transform = new FNX.Transform();
        transform.setProjection(70, engine.canvas.width, engine.canvas.height, 0.1, 100);
        let t = 0;

        engine.run(() => {
            t += engine.deltaTime;

            if(mesh.shader.compiled) {
                transform.translate([Math.sin(t), 0, -5]);
                transform.scale([Math.sin(t),Math.sin(t),Math.sin(t)]);
                transform.rotate(Math.sin(t) * 2 * Math.PI, [0,1,1]);
                mesh.shader.bind();
                mesh.shader.setUniformMat4('transform', transform.getProjectedTransform());
                mesh.draw();
            }

            if(engine.input.getKey(13))
                console.log('pressed')
        });
    });
});

