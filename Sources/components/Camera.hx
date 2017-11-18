package components;

import kha.Image;
import kha.System;
import kha.graphics4.TextureFormat;
import kha.graphics4.DepthStencilFormat;
import edge.IComponent;
using glm.Mat4;

class Camera implements IComponent {
    @:allow(Game)
    public static var main(default, null):Camera = null;

	var fov:Float;
	var znear:Float;
	var zfar:Float;

    var p:Mat4;
    var v:Mat4;
    var vp:Mat4;

    var renderBuffer:Image;

	public function new(fov:Float, znear:Float = 0.1, zfar:Float = 100) {
		this.fov = fov;
		this.znear = znear;
		this.zfar = zfar;

        this.p = new Mat4().identity();
        this.v = new Mat4().identity();
        this.vp = new Mat4().identity();

        renderBuffer = Image.createRenderTarget(
            System.windowWidth(), System.windowHeight(),
            TextureFormat.RGBA32,
            DepthStencilFormat.DepthAutoStencilAuto
        );

        if(main == null) main = this;
	}
}
