package components;

import edge.IComponent;
import glm.GLM;
using glm.Mat4;
import glm.Vec3;
import kha.Image;
import kha.graphics4.TextureFormat;
import kha.graphics4.DepthStencilFormat;

class SunShadow implements IComponent {
	var znear:Float;
	var zfar:Float;
    
    var p:Mat4;
    var v:Mat4;
    var vp:Mat4;

    var image:Image;

    var dirty:Bool = true;

    public function new(znear:Float = 0.1, zfar:Float = 100) {
		this.znear = znear;
		this.zfar = zfar;
        
        this.p = new Mat4().identity();
        this.v = new Mat4().identity();
        this.vp = new Mat4().identity();

        this.image = Image.createRenderTarget(
            2048, 2028,
            TextureFormat.RGBA32,
            DepthStencilFormat.DepthAutoStencilAuto
        );
        //this.image = null;
    }
}
