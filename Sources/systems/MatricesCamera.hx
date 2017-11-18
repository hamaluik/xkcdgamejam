package systems;

import edge.ISystem;
import components.Transform;
import components.Camera;
import glm.GLM;
using glm.Mat4;

class MatricesCamera implements ISystem {
	function update(camera:Camera, transform:Transform) {
		camera.p = GLM.perspective(
			camera.fov,
			Game.state.w / Game.state.h,
			camera.znear, camera.zfar,
			camera.p
		);
        camera.v = transform.m.invert(camera.v);
        camera.vp = Mat4.multMat(camera.p, camera.v, camera.vp);
	}
}
