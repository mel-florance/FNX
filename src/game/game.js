var engine = new FNX.Engine('render');
let scene = new FNX.Scene('my_scene', engine);
var camera = new FNX.FlyingCamera(scene);
var assets = new FNX.Assets(scene);

const fps = document.querySelector('.fps');

Promise.all([
    // assets.loadBsp('aim_map'),
    assets.loadImage('ak47_diffuse.jpg'),
    assets.loadImage('m4a4_diffuse.png'),
    assets.loadImage('glock_diffuse.jpg'),
    assets.loadMesh('m4a4'),
    assets.loadMesh('ak47'),
    assets.loadMesh('glock'),
    assets.loadShader('basic'),
])
.then(data => {
    let texture = new FNX.Texture(scene, data[0]);
    let texture2 = new FNX.Texture(scene, data[1]);
    let texture3 = new FNX.Texture(scene, data[2]);
    let ak47 = scene.getMeshByName('ak47');
    let m4a4 = scene.getMeshByName('m4a4');
    let box = scene.getMeshByName('glock');

    ak47.setMaterial(new FNX.BasicMaterial('ak47_mat', scene));
    ak47.material.setDiffuseTexture(texture);

    m4a4.setMaterial(new FNX.BasicMaterial('m4a4_mat', scene));
    m4a4.material.setDiffuseTexture(texture2);

    box.setMaterial(new FNX.BasicMaterial('box_mat', scene));
    box.material.setDiffuseTexture(texture3);

    let angle = 0;

    fps.textContent = engine.fps + ' fps';
    setInterval(() => {
        fps.textContent = engine.fps + ' fps'
    }, 1000);

    engine.input.pointerLock();

    engine.run(() => {

        angle += 0.005;
        camera.update();

        m4a4.transform.translate([-5.0, 0, -6]);
        m4a4.transform.rotate(angle, [0, 1, 0]);

        ak47.transform.rotate(angle, [0, -1, 0]);
        ak47.transform.translate([0, 0, -6]);

        box.transform.scale([6, 6, 6]);
        box.transform.rotate(angle, [0, 1, 0]);
        box.transform.translate([5, 0, -6]);

        engine.render();
    });
});
