import js.html.CanvasElement;
import js.Browser;
import js.html.Window;
import js.html.CanvasRenderingContext2D;

class DDComponentSample {
    private static var dnd: CanvasElement;
    private static var gdi: CanvasRenderingContext2D;
    private static var win: Window;
    public static function main(): Void {
        dnd = cast(Browser.document.getElementById("dnd"));
        gdi = dnd.getContext2d();
        win = Browser.window;

        hookfit();
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
}