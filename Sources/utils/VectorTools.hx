package utils;

using glm.Mat4;
using glm.Vec3;

class VectorTools {
    public static function localDirectionToWorld(d:Vec3, model:Mat4, dest:Vec3):Vec3 {
        dest.x = model.r0c0 * d.x + model.r0c1 * d.y + model.r0c2 * d.z;
        dest.y = model.r1c0 * d.x + model.r1c1 * d.y + model.r1c2 * d.z;
        dest.z = model.r2c0 * d.x + model.r2c1 * d.y + model.r2c2 * d.z;
        dest.normalize(dest);
        return dest;
    }
}
