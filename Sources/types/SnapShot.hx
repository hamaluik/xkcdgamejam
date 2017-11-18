package types;

import kha.Image;
import kha.System;
import kha.graphics4.TextureFormat;
import kha.graphics4.DepthStencilFormat;

class SnapShot {
    public var photo:Image = null;
    public var taken:Bool = false;

    public function new() {
        photo = Image.createRenderTarget(
            System.windowWidth(), System.windowHeight(),
            TextureFormat.RGBA32,
            DepthStencilFormat.DepthAutoStencilAuto
        );
    }
}
