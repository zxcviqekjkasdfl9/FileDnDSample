import js.html.CanvasElement;
import js.Browser;
import js.html.Window;
import js.html.CanvasRenderingContext2D;
import js.html.FileReader;
import js.html.FormData;

class DDComponentSample {
    private static var dnd: CanvasElement;
    private static var gdi: CanvasRenderingContext2D;
    private static var win: Window;
    public static function main(): Void {
        dnd = cast(Browser.document.getElementById("dnd"));
        gdi = dnd.getContext2d();
        win = Browser.window;

        hookfit();
        
        var dndenabled: Bool = dndEnabled();
        log('the browser supports file drag and drop: ${dndenabled}');
    }

    private static function dndEnabled(): Bool {
        var d: CanvasElement = dnd;
        if (untyped __js__("'draggable' in d")
            && untyped __js__("'ondrop' in d")
            && untyped window.FormData
            && untyped window.FileReader) {
            return true;
        } else {
            return false;
        }
    }

    private static function hookfit(): Void {
        win.addEventListener("resize", fit);
        win.addEventListener("load", fit);
    }

    private static function fit(): Void {
        var w: Int = win.innerWidth;
        var h: Int = win.innerHeight;

        dnd.width = w;
        dnd.height = h;
        
        gdi.fillStyle = "rgb(200, 200, 255)";
        gdi.fillRect(0, 0, w, h);
    }

    private static function log(x: Dynamic): Void {
        Browser.console.log(x);
    }
}