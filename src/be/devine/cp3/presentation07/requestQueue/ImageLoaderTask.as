package be.devine.cp3.presentation07.requestQueue {
import flash.display.Loader;
import flash.errors.ScriptTimeoutError;
import flash.events.Event;
import flash.net.URLRequest;

public class ImageLoaderTask extends Loader implements IQueueTask{

    private var imageUrl:String;

    public function ImageLoaderTask(imageURL:String) {
        this.imageUrl = imageURL;
    }

    public function start():void{
        this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        this.load(new URLRequest(imageUrl));
    }

    private function completeHandler(event:Event):void {
        this.dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
