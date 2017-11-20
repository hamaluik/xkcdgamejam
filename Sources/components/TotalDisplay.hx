package components;

import edge.IComponent;
import types.SnapShotAnalysis;

class TotalDisplay implements IComponent {
    var grandTotal:Int;

    public function new() {
        grandTotal = 0;
        for(a in SnapShotAnalysis.finalResults.iterator()) {
            grandTotal += a.total;
        }
    }
}
