package types;

import kha.graphics4.VertexStructure;
import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexData;
import kha.graphics4.Usage;
import haxe.ds.Vector;
import glm.Vec3;

class Mesh {
    public var min(default, null):Vec3 = new Vec3(0, 0, 0);
    public var max(default, null):Vec3 = new Vec3(0, 0, 0);
    public var vertexBuffer(default, null):VertexBuffer;
	public var indexBuffer(default, null):IndexBuffer;

    public function new(positions:Vector<Float>, normals:Vector<Float>, texcoords:Vector<Float>, indices:Vector<Int>) {
        var structure:VertexStructure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal",   VertexData.Float3);
        structure.add("texcoord", VertexData.Float2);

        var numVerts:Int = Std.int(positions.length / 3);

        vertexBuffer = new VertexBuffer(numVerts, structure, Usage.StaticUsage);
        var vbData = vertexBuffer.lock();
        for(v in 0...numVerts) {
            var px:Float = positions[(v * 3) + 0];
            var py:Float = positions[(v * 3) + 1];
            var pz:Float = positions[(v * 3) + 2];

            vbData[(v * 8) + 0] = px;
            vbData[(v * 8) + 1] = py;
            vbData[(v * 8) + 2] = pz;

            vbData[(v * 8) + 3] = normals[(v * 3) + 0];
            vbData[(v * 8) + 4] = normals[(v * 3) + 1];
            vbData[(v * 8) + 5] = normals[(v * 3) + 2];

            vbData[(v * 8) + 6] = texcoords[(v * 2) + 0];
            vbData[(v * 8) + 7] = texcoords[(v * 2) + 1];

            if(px < min.x) min.x = px;
            if(px > max.x) max.x = px;
            if(py < min.y) min.y = py;
            if(py > max.y) max.y = py;
            if(pz < min.z) min.z = pz;
            if(pz > max.z) max.z = pz;
        }
        vertexBuffer.unlock();

		indexBuffer = new IndexBuffer(indices.length, Usage.StaticUsage);
		var iData = indexBuffer.lock();
		for (i in 0...iData.length) {
			iData[i] = indices[i];
		}
		indexBuffer.unlock();
    }

    public static function fromGLTFPrimitive(mesh:gltf.types.MeshPrimitive) {
        return new Mesh(
            mesh.getFloatAttributeValues("POSITION"),
            mesh.getFloatAttributeValues("NORMAL"),
            mesh.getFloatAttributeValues("TEXCOORD_9"),
            mesh.getIndexValues()
        );
    }
}
