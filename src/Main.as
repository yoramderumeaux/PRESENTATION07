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
    //private var percentage:PercentagePreloader;


    //CONSTRUCTOR
    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;

        /*var background:Sprite = new Sprite();
        background.graphics.beginFill(0x66b34e);
        background.graphics.drawRect(0, 0,  stage.nativeWindow.width,  stage.nativeWindow.height);
        background.graphics.endFill();
        addChild(background);    */

        //percentage = new PercentagePreloader();
        //percentage.stop();
        //addChild(percentage);


        if( loaderInfo.bytesLoaded != loaderInfo.bytesTotal ){
            this.loaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler  );
            this.loaderInfo.addEventListener( Event.COMPLETE, LoadedHandler );
        }else{
            startApp();
        }


    }

    private function progressHandler( e:ProgressEvent ):void {
        //trace(e.bytesLoaded, e.bytesTotal);
        var p:int =  (e.bytesLoaded / e.bytesTotal) * 100;
        //percentage.gotoAndStop(p);
        trace ("[MAIN]Percentage p: " + p);


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
