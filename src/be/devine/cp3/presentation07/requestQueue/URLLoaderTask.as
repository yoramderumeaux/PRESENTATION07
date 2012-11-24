package be.devine.cp3.presentation07.requestQueue {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class URLLoaderTask extends URLLoader implements IQueueTask{

    private var url:String;

    public function URLLoaderTask(url:String) {

        this.url = url;


    }

    public function start():void{
        this.addEventListener(Event.COMPLETE, completeHandler);
        this.load(new URLRequest(url));
    }

    private function completeHandler(event:Event):void {
    }
}
}
