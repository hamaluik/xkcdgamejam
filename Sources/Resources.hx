import kha.Assets;
import kha.Image;
import gltf.GLTF;
import types.Mesh;

@:allow(Game)
class Resources {
    public var cube(default, null):Mesh;
    public var uvgrid(default, null):Image;

    function new() {
        var cube_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Cube_gltf.toString(),
            [Assets.blobs.Cube_bin.bytes]
        );
        cube = Mesh.fromGLTFPrimitive(cube_g.meshes[0].primitives[0]);

        uvgrid = Assets.images.uvgrid;
    }
}
