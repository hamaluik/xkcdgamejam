import kha.Assets;
import kha.Image;
import kha.Font;
import gltf.GLTF;
import types.Mesh;
import glm.Vec4;
import glm.Vec3;

@:allow(Game)
class Resources {
    public var palette(default, null):Image;
    public var cameraOverlay(default, null):Image;
    public var font(default, null):Font;

    public var bun1(default, null):Mesh;
    public var bun2(default, null):Mesh;
    public var bunKing(default, null):Mesh;
    public var deadOak1(default, null):Mesh;
    public var deadOak2(default, null):Mesh;
    public var deadOak3(default, null):Mesh;
    public var deadSpruce1(default, null):Mesh;
    public var deadSpruce2(default, null):Mesh;
    public var deadSpruce3(default, null):Mesh;
    public var oakTree1(default, null):Mesh;
    public var oakTree2(default, null):Mesh;
    public var oakTree3(default, null):Mesh;
    public var spruceTree1(default, null):Mesh;
    public var spruceTree2(default, null):Mesh;
    public var spruceTree3(default, null):Mesh;
    public var ground(default, null):Mesh;

    public var forest(default, null):Array<{ mesh:Mesh, bunFactor:Vec4, pos:Vec3, radius:Float }>;

    function new() {
        palette = Assets.images.palette;
        cameraOverlay = Assets.images.cameraoverlay;
        font = Assets.fonts.Targa;

        var Bun1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Bun1_gltf.toString(),
            [Assets.blobs.Bun1_bin.bytes]
        );
        bun1 = Mesh.fromGLTFPrimitive(Bun1_g.meshes[0].primitives[0]);

        var Bun2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Bun2_gltf.toString(),
            [Assets.blobs.Bun2_bin.bytes]
        );
        bun2 = Mesh.fromGLTFPrimitive(Bun2_g.meshes[0].primitives[0]);

        var BunKing_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BunKing_gltf.toString(),
            [Assets.blobs.BunKing_bin.bytes]
        );
        bunKing = Mesh.fromGLTFPrimitive(BunKing_g.meshes[0].primitives[0]);

        var DeadOak1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadOak1_gltf.toString(),
            [Assets.blobs.DeadOak1_bin.bytes]
        );
        deadOak1 = Mesh.fromGLTFPrimitive(DeadOak1_g.meshes[0].primitives[0]);

        var DeadOak2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadOak2_gltf.toString(),
            [Assets.blobs.DeadOak2_bin.bytes]
        );
        deadOak2 = Mesh.fromGLTFPrimitive(DeadOak2_g.meshes[0].primitives[0]);

        var DeadOak3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadOak3_gltf.toString(),
            [Assets.blobs.DeadOak3_bin.bytes]
        );
        deadOak3 = Mesh.fromGLTFPrimitive(DeadOak3_g.meshes[0].primitives[0]);

        var DeadSpruce1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadSpruce1_gltf.toString(),
            [Assets.blobs.DeadSpruce1_bin.bytes]
        );
        deadSpruce1 = Mesh.fromGLTFPrimitive(DeadSpruce1_g.meshes[0].primitives[0]);

        var DeadSpruce2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadSpruce2_gltf.toString(),
            [Assets.blobs.DeadSpruce2_bin.bytes]
        );
        deadSpruce2 = Mesh.fromGLTFPrimitive(DeadSpruce2_g.meshes[0].primitives[0]);

        var DeadSpruce3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.DeadSpruce3_gltf.toString(),
            [Assets.blobs.DeadSpruce3_bin.bytes]
        );
        deadSpruce3 = Mesh.fromGLTFPrimitive(DeadSpruce3_g.meshes[0].primitives[0]);

        var OakTree1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.OakTree1_gltf.toString(),
            [Assets.blobs.OakTree1_bin.bytes]
        );
        oakTree1 = Mesh.fromGLTFPrimitive(OakTree1_g.meshes[0].primitives[0]);

        var OakTree2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.OakTree2_gltf.toString(),
            [Assets.blobs.OakTree2_bin.bytes]
        );
        oakTree2 = Mesh.fromGLTFPrimitive(OakTree2_g.meshes[0].primitives[0]);

        var OakTree3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.OakTree3_gltf.toString(),
            [Assets.blobs.OakTree3_bin.bytes]
        );
        oakTree3 = Mesh.fromGLTFPrimitive(OakTree3_g.meshes[0].primitives[0]);

        var SpruceTree1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.SpruceTree1_gltf.toString(),
            [Assets.blobs.SpruceTree1_bin.bytes]
        );
        spruceTree1 = Mesh.fromGLTFPrimitive(SpruceTree1_g.meshes[0].primitives[0]);

        var SpruceTree2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.SpruceTree2_gltf.toString(),
            [Assets.blobs.SpruceTree2_bin.bytes]
        );
        spruceTree2 = Mesh.fromGLTFPrimitive(SpruceTree2_g.meshes[0].primitives[0]);

        var SpruceTree3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.SpruceTree3_gltf.toString(),
            [Assets.blobs.SpruceTree3_bin.bytes]
        );
        spruceTree3 = Mesh.fromGLTFPrimitive(SpruceTree3_g.meshes[0].primitives[0]);

        var Ground_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Ground_gltf.toString(),
            [Assets.blobs.Ground_bin.bytes]
        );
        ground = Mesh.fromGLTFPrimitive(Ground_g.meshes[0].primitives[0]);

        var Forest_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Forest_gltf.toString(), []
        );
        forest = [];
        for(node in Forest_g.defaultScene.nodes) {
            if(node.mesh == null) continue;
            var n = {
                pos: node.translation == null ? new Vec3() : new Vec3(node.translation[0], node.translation[1], node.translation[2]),
                bunFactor: switch(node.mesh.name) {
                    case 'Bun1': new Vec4(1, 0, 0, 1);
                    case 'Bun2': new Vec4(0, 1, 0, 1);
                    case 'BunKing': new Vec4(0, 0, 1, 1);
                    default: new Vec4(0, 0, 0, 1);
                },
                mesh: switch(node.mesh.name) {
                    case 'Bun1': bun1;
                    case 'Bun2': bun2;
                    case 'BunKing': bunKing;
                    case 'DeadOak1': deadOak1;
                    case 'DeadOak2': deadOak2;
                    case 'DeadOak3': deadOak3;
                    case 'DeadSpruce1': deadSpruce1;
                    case 'DeadSpruce2': deadSpruce2;
                    case 'DeadSpruce3': deadSpruce3;
                    case 'OakTree1': oakTree1;
                    case 'OakTree2': oakTree2;
                    case 'OakTree3': oakTree3;
                    case 'SpruceTree1': spruceTree1;
                    case 'SpruceTree2': spruceTree2;
                    case 'SpruceTree3': spruceTree3;
                    case 'Ground': ground;
                    default: null;
                },
                radius: switch(node.mesh.name) {
                    case 'DeadOak1': 1.0;
                    case 'DeadOak2': 1.0;
                    case 'DeadOak3': 1.0;
                    case 'DeadSpruce1': 1.0;
                    case 'DeadSpruce2': 1.0;
                    case 'DeadSpruce3': 1.0;
                    case 'OakTree1': 1.0;
                    case 'OakTree2': 1.0;
                    case 'OakTree3': 1.0;
                    case 'SpruceTree1': 1.0;
                    case 'SpruceTree2': 1.0;
                    case 'SpruceTree3': 1.0;
                    default: -1.0;
                }
            };
            if(n.mesh != null) forest.push(n);
        }
    }
}
