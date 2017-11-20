import kha.Assets;
import kha.Image;
import kha.Font;
import kha.Sound;
import gltf.GLTF;
import types.Mesh;
import glm.Quat;
import glm.Vec4;
import glm.Vec3;
using StringTools;

@:allow(Game)
class Resources {
    public var bmgLogo(default, null):Image;
    public var comic(default, null):Image;
    public var palette(default, null):Image;
    public var cameraOverlay(default, null):Image;
    public var muteIcon(default, null):Image;
    public var camFont(default, null):Font;
    public var xkcdFont(default, null):Font;
    public var font(default, null):Font;
    public var ambience(default, null):Sound;
    public var teacher(default, null):Image;
    public var cameraSound(default, null):Sound;
    public var footLeft(default, null):Sound;
    public var footRight(default, null):Sound;

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
    public var grass(default, null):Mesh;

    public var BigRock1(default, null):Mesh;
    public var BigRock2(default, null):Mesh;
    public var BigRock3(default, null):Mesh;
    public var BigRock4(default, null):Mesh;
    public var BigRock5(default, null):Mesh;

    public var Rock1(default, null):Mesh;
    public var Rock2(default, null):Mesh;
    public var Rock3(default, null):Mesh;
    public var Rock4(default, null):Mesh;
    public var Rock5(default, null):Mesh;
    public var Rock6(default, null):Mesh;
    public var Rock7(default, null):Mesh;
    public var Rock8(default, null):Mesh;
    public var Rock9(default, null):Mesh;
    public var Rock_10(default, null):Mesh;
    public var Rock_11(default, null):Mesh;
    public var Rock_12(default, null):Mesh;
    public var Rock_13(default, null):Mesh;
    public var Rock_14(default, null):Mesh;
    public var Rock_15(default, null):Mesh;
    public var Rock_16(default, null):Mesh;
    public var Rock_17(default, null):Mesh;
    public var Rock_18(default, null):Mesh;
    public var Rock_19(default, null):Mesh;
    public var Rock_20(default, null):Mesh;
    public var Rock_21(default, null):Mesh;
    public var Rock_22(default, null):Mesh;
    public var Rock_23(default, null):Mesh;
    public var Rock_24(default, null):Mesh;
    public var Rock_25(default, null):Mesh;

    public var forest(default, null):Array<{ mesh:Mesh, pos:Vec3, rot:Quat, radius:Float }>;
    public var bunSpawns(default, null):Array<{ pos:Vec3, rot:Quat }>;

    function new() {
        bmgLogo = Assets.images.blazingmammothgames;
        comic = Assets.images.comic;
        palette = Assets.images.palette;
        cameraOverlay = Assets.images.cameraoverlay;
        muteIcon = Assets.images.mute;
        camFont = Assets.fonts.Targa;
        xkcdFont = Assets.fonts.xkcd;
        ambience = Assets.sounds._288899__petebuchwald__rocky_mountain_outdoors_wind_and_birds;
        teacher = Assets.images.teacher;
        cameraSound = Assets.sounds.camera_shutter_click_03;
        footLeft = Assets.sounds.footstep_left;
        footRight = Assets.sounds.footstep_right;

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

        var BigRock1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BigRock1_gltf.toString(),
            [Assets.blobs.BigRock1_bin.bytes]
        );
        BigRock1 = Mesh.fromGLTFPrimitive(BigRock1_g.meshes[0].primitives[0]);

        var BigRock2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BigRock2_gltf.toString(),
            [Assets.blobs.BigRock2_bin.bytes]
        );
        BigRock2 = Mesh.fromGLTFPrimitive(BigRock2_g.meshes[0].primitives[0]);

        var BigRock3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BigRock3_gltf.toString(),
            [Assets.blobs.BigRock3_bin.bytes]
        );
        BigRock3 = Mesh.fromGLTFPrimitive(BigRock3_g.meshes[0].primitives[0]);

        var BigRock4_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BigRock4_gltf.toString(),
            [Assets.blobs.BigRock4_bin.bytes]
        );
        BigRock4 = Mesh.fromGLTFPrimitive(BigRock4_g.meshes[0].primitives[0]);

        var BigRock5_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.BigRock5_gltf.toString(),
            [Assets.blobs.BigRock5_bin.bytes]
        );
        BigRock5 = Mesh.fromGLTFPrimitive(BigRock5_g.meshes[0].primitives[0]);

        var Rock1_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock1_gltf.toString(),
            [Assets.blobs.Rock1_bin.bytes]
        );
        Rock1 = Mesh.fromGLTFPrimitive(Rock1_g.meshes[0].primitives[0]);

        var Rock2_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock2_gltf.toString(),
            [Assets.blobs.Rock2_bin.bytes]
        );
        Rock2 = Mesh.fromGLTFPrimitive(Rock2_g.meshes[0].primitives[0]);

        var Rock3_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock3_gltf.toString(),
            [Assets.blobs.Rock3_bin.bytes]
        );
        Rock3 = Mesh.fromGLTFPrimitive(Rock3_g.meshes[0].primitives[0]);

        var Rock4_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock4_gltf.toString(),
            [Assets.blobs.Rock4_bin.bytes]
        );
        Rock4 = Mesh.fromGLTFPrimitive(Rock4_g.meshes[0].primitives[0]);

        var Rock5_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock5_gltf.toString(),
            [Assets.blobs.Rock5_bin.bytes]
        );
        Rock5 = Mesh.fromGLTFPrimitive(Rock5_g.meshes[0].primitives[0]);

        var Rock6_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock6_gltf.toString(),
            [Assets.blobs.Rock6_bin.bytes]
        );
        Rock6 = Mesh.fromGLTFPrimitive(Rock6_g.meshes[0].primitives[0]);

        var Rock7_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock7_gltf.toString(),
            [Assets.blobs.Rock7_bin.bytes]
        );
        Rock7 = Mesh.fromGLTFPrimitive(Rock7_g.meshes[0].primitives[0]);

        var Rock8_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock8_gltf.toString(),
            [Assets.blobs.Rock8_bin.bytes]
        );
        Rock8 = Mesh.fromGLTFPrimitive(Rock8_g.meshes[0].primitives[0]);

        var Rock9_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock9_gltf.toString(),
            [Assets.blobs.Rock9_bin.bytes]
        );
        Rock9 = Mesh.fromGLTFPrimitive(Rock9_g.meshes[0].primitives[0]);

        var Rock_10_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_10_gltf.toString(),
            [Assets.blobs.Rock_10_bin.bytes]
        );
        Rock_10 = Mesh.fromGLTFPrimitive(Rock_10_g.meshes[0].primitives[0]);

        var Rock_11_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_11_gltf.toString(),
            [Assets.blobs.Rock_11_bin.bytes]
        );
        Rock_11 = Mesh.fromGLTFPrimitive(Rock_11_g.meshes[0].primitives[0]);

        var Rock_12_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_12_gltf.toString(),
            [Assets.blobs.Rock_12_bin.bytes]
        );
        Rock_12 = Mesh.fromGLTFPrimitive(Rock_12_g.meshes[0].primitives[0]);

        var Rock_13_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_13_gltf.toString(),
            [Assets.blobs.Rock_13_bin.bytes]
        );
        Rock_13 = Mesh.fromGLTFPrimitive(Rock_13_g.meshes[0].primitives[0]);

        var Rock_14_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_14_gltf.toString(),
            [Assets.blobs.Rock_14_bin.bytes]
        );
        Rock_14 = Mesh.fromGLTFPrimitive(Rock_14_g.meshes[0].primitives[0]);

        var Rock_15_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_15_gltf.toString(),
            [Assets.blobs.Rock_15_bin.bytes]
        );
        Rock_15 = Mesh.fromGLTFPrimitive(Rock_15_g.meshes[0].primitives[0]);

        var Rock_16_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_16_gltf.toString(),
            [Assets.blobs.Rock_16_bin.bytes]
        );
        Rock_16 = Mesh.fromGLTFPrimitive(Rock_16_g.meshes[0].primitives[0]);

        var Rock_17_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_17_gltf.toString(),
            [Assets.blobs.Rock_17_bin.bytes]
        );
        Rock_17 = Mesh.fromGLTFPrimitive(Rock_17_g.meshes[0].primitives[0]);

        var Rock_18_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_18_gltf.toString(),
            [Assets.blobs.Rock_18_bin.bytes]
        );
        Rock_18 = Mesh.fromGLTFPrimitive(Rock_18_g.meshes[0].primitives[0]);

        var Rock_19_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_19_gltf.toString(),
            [Assets.blobs.Rock_19_bin.bytes]
        );
        Rock_19 = Mesh.fromGLTFPrimitive(Rock_19_g.meshes[0].primitives[0]);

        var Rock_20_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_20_gltf.toString(),
            [Assets.blobs.Rock_20_bin.bytes]
        );
        Rock_20 = Mesh.fromGLTFPrimitive(Rock_20_g.meshes[0].primitives[0]);

        var Rock_21_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_21_gltf.toString(),
            [Assets.blobs.Rock_21_bin.bytes]
        );
        Rock_21 = Mesh.fromGLTFPrimitive(Rock_21_g.meshes[0].primitives[0]);

        var Rock_22_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_22_gltf.toString(),
            [Assets.blobs.Rock_22_bin.bytes]
        );
        Rock_22 = Mesh.fromGLTFPrimitive(Rock_22_g.meshes[0].primitives[0]);

        var Rock_23_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_23_gltf.toString(),
            [Assets.blobs.Rock_23_bin.bytes]
        );
        Rock_23 = Mesh.fromGLTFPrimitive(Rock_23_g.meshes[0].primitives[0]);

        var Rock_24_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_24_gltf.toString(),
            [Assets.blobs.Rock_24_bin.bytes]
        );
        Rock_24 = Mesh.fromGLTFPrimitive(Rock_24_g.meshes[0].primitives[0]);

        var Rock_25_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Rock_25_gltf.toString(),
            [Assets.blobs.Rock_25_bin.bytes]
        );
        Rock_25 = Mesh.fromGLTFPrimitive(Rock_25_g.meshes[0].primitives[0]);

        var Ground_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Ground_gltf.toString(),
            [Assets.blobs.Ground_bin.bytes]
        );
        ground = Mesh.fromGLTFPrimitive(Ground_g.meshes[0].primitives[0]);

        var Grass_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Grass_gltf.toString(),
            [Assets.blobs.Grass_bin.bytes]
        );
        grass = Mesh.fromGLTFPrimitive(Grass_g.meshes[0].primitives[0]);

        var Forest_g:GLTF = GLTF.parseAndLoad(
            Assets.blobs.Forest_gltf.toString(), []
        );
        forest = [];
        bunSpawns = [];
        for(node in Forest_g.defaultScene.nodes) {
            if(node.mesh == null && node.name != null && node.name.startsWith("BunSpawn")) {
                bunSpawns.push({
                    pos: node.translation == null ? new Vec3() : new Vec3(node.translation[0], node.translation[1], node.translation[2]),
                    rot: node.rotation == null ? Quat.identity(new Quat()) : new Quat(node.rotation[0], node.rotation[1], node.rotation[2], node.rotation[3])
                });
            }
            else if(node.mesh != null) {
                var n = {
                    pos: node.translation == null ? new Vec3() : new Vec3(node.translation[0], node.translation[1], node.translation[2]),
                    rot: node.rotation == null ? Quat.identity(new Quat()) : new Quat(node.rotation[0], node.rotation[1], node.rotation[2], node.rotation[3]),
                    mesh: switch(node.mesh.name) {
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
                        case 'BigRock1': BigRock1;
                        case 'BigRock2': BigRock2;
                        case 'BigRock3': BigRock3;
                        case 'BigRock4': BigRock4;
                        case 'BigRock5': BigRock5;
                        case 'Rock1': Rock1;
                        case 'Rock2': Rock2;
                        case 'Rock3': Rock3;
                        case 'Rock4': Rock4;
                        case 'Rock5': Rock5;
                        case 'Rock6': Rock6;
                        case 'Rock7': Rock7;
                        case 'Rock8': Rock8;
                        case 'Rock9': Rock9;
                        case 'Rock_10': Rock_10;
                        case 'Rock_11': Rock_11;
                        case 'Rock_12': Rock_12;
                        case 'Rock_13': Rock_13;
                        case 'Rock_14': Rock_14;
                        case 'Rock_15': Rock_15;
                        case 'Rock_16': Rock_16;
                        case 'Rock_17': Rock_17;
                        case 'Rock_18': Rock_18;
                        case 'Rock_19': Rock_19;
                        case 'Rock_20': Rock_20;
                        case 'Rock_21': Rock_21;
                        case 'Rock_22': Rock_22;
                        case 'Rock_23': Rock_23;
                        case 'Rock_24': Rock_24;
                        case 'Rock_25': Rock_25;
                        case 'Ground': ground;
                        case 'Grass': grass;
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
                        case 'BigRock1': 14.390492/2;
                        case 'BigRock2': 14.074665/2;
                        case 'BigRock3': 9.296192/2;
                        case 'BigRock4': 13.456812/2;
                        case 'BigRock5': 15.968085/2;
                        case 'Rock1': 2.731365/2;
                        case 'Rock2': 2.262327/2;
                        case 'Rock3': 3.852593/2;
                        case 'Rock4': 1.794132/2;
                        case 'Rock5': 2.838603/2;
                        case 'Rock6': 4.09047/2;
                        case 'Rock7': 3.981763/2;
                        case 'Rock8': 3.439961/2;
                        case 'Rock9': 4.16308/2;
                        case 'Rock_10': 3.46364/2;
                        case 'Rock_11': 4.819511/2;
                        case 'Rock_12': 4.908013/2;
                        case 'Rock_13': 4.48035/2;
                        case 'Rock_14': 3.870732/2;
                        case 'Rock_15': 3.332937/2;
                        case 'Rock_16': 3.248413/2;
                        case 'Rock_17': 4.778868/2;
                        case 'Rock_18': 4.843359/2;
                        case 'Rock_19': 4.471061/2;
                        case 'Rock_20': 4.757059/2;
                        case 'Rock_21': 4.993942/2;
                        case 'Rock_22': 6.999255/2;
                        case 'Rock_23': 4.545128/2;
                        case 'Rock_24': 5.403552/2;
                        case 'Rock_25': 4.18101/2;
                        default: -1.0;
                    }
                };
                if(n.mesh != null) forest.push(n);
            }
        }
    }
}
