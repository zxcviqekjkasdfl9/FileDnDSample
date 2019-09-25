import js.html.CanvasElement;
import js.Browser;
import js.html.Window;
import js.html.CanvasRenderingContext2D;
import js.html.FileReader;
import js.html.FormData;
import js.html.DragEvent;
import js.html.DataTransfer;
import js.html.FileList;

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
        if (!dndenabled) {
            return;
        }

        hookdnd();
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

    private static function hookdnd(): Void {
        for (stop in ["drag", "dragstart", "dragend", "dragover", "dragenter", "dragleave"]) {
            dnd.addEventListener(stop, stopEvent);
        }
        dnd.addEventListener("drop", logFiles);
    }

    private static function logFiles(e: DragEvent): Void {
        stopEvent(e);
        var files: FileList = e.dataTransfer.files;
        for (pos in 0...files.length) {
            log(files.item(pos));
        }
    }

    private static function stopEvent(e: DragEvent): Void {
        e.preventDefault();
        e.stopPropagation();
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