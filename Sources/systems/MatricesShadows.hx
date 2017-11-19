package systems;

import edge.ISystem;
import components.Transform;
import components.SunShadow;
import components.LightDirection;
import glm.GLM;
using glm.Mat4;
using glm.Vec3;
using utils.VectorTools;

class MatricesShadows implements ISystem {
	var forward:Vec3 = new Vec3(0, 0, 1);

	function update(ss:SunShadow, transform:Transform, ld:LightDirection) {
		//ss.p = GLM.perspective(Math.PI/2, 1, ss.znear, ss.zfar, ss.p);
		// TODO: optimize this!
		//if(ss.rendered) return;
		ss.p = GLM.orthographic(-75, 75, -75, 75, ss.znear, ss.zfar, ss.p);
        ss.v = transform.m.invert(ss.v);
        ss.vp = Mat4.multMat(ss.p, ss.v, ss.vp);
		forward.localDirectionToWorld(transform.m, ld.direction);
	}
}
