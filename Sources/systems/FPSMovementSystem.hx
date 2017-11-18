package systems;

import edge.ISystem;
import components.FPSMovement;
import components.Transform;
import components.Velocity;
using utils.VectorTools;
using glm.Vec3;
using glm.Vec2;

class FPSMovementSystem implements ISystem {
    static var forward:Vec3 = new Vec3(0, 0, -1);
    static var right:Vec3 = new Vec3(1, 0, 0);
    var localForward:Vec3 = new Vec3();
    var localRight:Vec3 = new Vec3();
    var flatDir:Vec2 = new Vec2();

    function update(f:FPSMovement, t:Transform, vel:Velocity) {
        forward.localDirectionToWorld(t.m, localForward);
        right.localDirectionToWorld(t.m, localRight);
        flatDir.x = localForward.x * Game.state.forwardBackwardAxis + localRight.x * Game.state.rightLeftAxis;
        flatDir.y = localForward.z * Game.state.forwardBackwardAxis + localRight.z * Game.state.rightLeftAxis;
        flatDir.normalize(flatDir);

        vel.v.x = flatDir.x * f.speed;
        vel.v.z = flatDir.y * f.speed;
    }
}
