package components;

import edge.IComponent;
import types.Mesh;
import kha.Image;
using glm.Mat4;
import glm.Vec4;

class MeshRender implements IComponent {
    var mesh:Mesh;
    var bunFactor:Vec4;
    var texture:Image;
    var shadowMVP:Mat4;

    public function new(mesh:Mesh, bunFactor:Vec4, texture:Image) {
        this.mesh = mesh;
        this.bunFactor = bunFactor;
        this.texture = texture;
        this.shadowMVP = new Mat4().identity();
    }
}
