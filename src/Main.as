package {

import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.model.AppModel;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.system.Capabilities;

import starling.core.Starling;


public class Main extends Sprite {

    //PROPERTIES
    private var starling:Starling;
    private var appModel:AppModel;

    //CONSTRUCTOR
    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;

        //github push test, fixed?

        starling = new Starling(Application,stage);
        starling.start();

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.PRESENTATION_STARTED, goFullscreen);
        appModel.addEventListener(AppModel.PRESENTATION_STOPPED, normalView);

        appModel.appWidth = 1024;
        appModel.appheigth = 768;

        stage.addEventListener(Event.RESIZE, resizeHandler);
        resizeHandler(null);

        stage.nativeWindow.x = (Capabilities.screenResolutionX >> 1) - (appModel.appWidth >> 1);
        stage.nativeWindow.y = (Capabilities.screenResolutionY >> 1) - (appModel.appheigth >> 1);
    }

    private function goFullscreen(e:Event):void{
        stage.nativeWindow.width = Capabilities.screenResolutionX;
        stage.nativeWindow.height = Capabilities.screenResolutionY;
        appModel.appWidth = Capabilities.screenResolutionX;
        appModel.appheigth = Capabilities.screenResolutionY;
        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
    }

    private function normalView(e:Event):void{
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;
        appModel.appWidth = 1024;
        appModel.appheigth = 768;

        stage.nativeWindow.x = (Capabilities.screenResolutionX >> 1) - (appModel.appWidth >> 1);
        stage.nativeWindow.y = (Capabilities.screenResolutionY >> 1) - (appModel.appheigth >> 1);
    }

    private function resizeHandler(event:Event):void{
        var viewPortRectangle:Rectangle = new Rectangle();
        viewPortRectangle.width = stage.stageWidth;
        viewPortRectangle.height = stage.stageHeight;

        // resize the viewport:
        Starling.current.viewPort = viewPortRectangle;
        starling.stage.stageWidth = stage.stageWidth;
        starling.stage.stageHeight = stage.stageHeight;

        // assign the new stage width and height:
        appModel.appWidth = stage.stageWidth;
        appModel.appheigth = stage.stageHeight;
    }

}
}
