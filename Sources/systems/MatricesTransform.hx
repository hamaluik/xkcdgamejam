package systems;

import edge.ISystem;
import components.Transform;
import glm.GLM;

class MatricesTransform implements ISystem {
	function update(transform:Transform) {
		transform.m = GLM.transform(transform.pos, transform.rot, transform.sca, transform.m);
	}
}
