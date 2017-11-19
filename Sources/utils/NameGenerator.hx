package utils;
using StringTools;

class NameGenerator {
    static var mtitles:Array<String> = [
        "Mr.", "Master", "Lord", "Baron", "Viscount", "Earl", "Count", "Marquess", "Prince", "Duke", "Archduke"
    ];
    static var ftitles:Array<String> = [
        "Mrs.", "Mistress", "Lady", "Baroness", "Viscountess", "Countess", "Countess", "Marquess", "Princess", "Duchess", "Archduchess"
    ];
    
    static var fnames:Array<String> = [
        "Lily", "Candy", "Clumsy", "Flower", "Thumper", "Daffodil",
    ];
    static var lnames:Array<String> = [
        "Rabbit", "Bunny", "Fluffington", "Whiskers", "Nibbler", "Cottontail", "Fuzzybottom", "Hare", "Harington", "Hopman", "Marshmallow", "McWhiskers", "Snuffles", "Munchington", "Wabbit", "Flopsworth", "Hopper"
    ];

    static var suffices:Array<String> = [
        "", "", "", "", "", "Jr.", "Sr.", "II", "III", "IV", "V", "VI", "VII", "VIII", "IV"
    ];

    public static function generate(size:Float):String {
        var g:Int = Game.random.GetIn(0, 1);
        var t:Float = (size - Settings.minBunSize) / (Settings.maxBunSize / Settings.minBunSize);
        t = 1.0 - t;
        var ti:Int = Math.floor(t * (mtitles.length - 1));
        var title:String = switch(g) {
            case 0: size < Settings.minBunSize ? "King" : mtitles[ti];
            case 1: size < Settings.minBunSize ? "Queen" : ftitles[ti];
            case _: "";
        }

        var fname:String = fnames[Game.random.GetIn(0, fnames.length - 1)];
        var lname:String = lnames[Game.random.GetIn(0, lnames.length - 1)];
        var suffix:String = suffices[Game.random.GetIn(0, suffices.length - 1)];

        return '${title} ${fname} ${lname} ${suffix}'.trim();
    }
}
