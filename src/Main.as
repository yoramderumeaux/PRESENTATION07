package {

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.utils.getDefinitionByName;

public class Main extends MovieClip {
    //PROPERTIES
    private var _app:DisplayObject;

    //CONSTRUCTOR
    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        if( loaderInfo.bytesLoaded != loaderInfo.bytesTotal ){
            this.loaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler  );
            this.loaderInfo.addEventListener( Event.COMPLETE, LoadedHandler );
        }else{
            startApp();
        }
    }

    private function progressHandler( e:ProgressEvent ):void {
        trace(e.bytesLoaded, e.bytesTotal);
    }

    private function LoadedHandler( e:Event ):void {
        startApp();
    }

    private function startApp():void {
        this.gotoAndStop("start");

        var AppClass:Class = getDefinitionByName("be.devine.cp3.presentation07.Application") as Class;
        _app = new AppClass();
        addChild( _app );
    }
}
}
