package components;

import edge.IComponent;
import types.Mesh;
import kha.Image;
using glm.Mat4;

class MeshRender implements IComponent {
    var mesh:Mesh;
    var texture:Image;
    var shadowMVP:Mat4;

    public function new(mesh:Mesh, texture:Image) {
        this.mesh = mesh;
        this.texture = texture;
        this.shadowMVP = new Mat4().identity();
    }
}
