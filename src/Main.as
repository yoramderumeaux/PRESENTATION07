package {

import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.model.AppModel;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
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

        starling = new Starling(Application,stage);
        starling.start();

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.PRESENTATION_STARTED, goFullscreen);

        appModel.appWidth = 1024;
        appModel.appheigth = 768;
    }

    private function goFullscreen(e:Event):void{
        //activeren fullscreen (werkt ng niet)
        /*stage.nativeWindow.width = Capabilities.screenResolutionX;
        stage.nativeWindow.height = Capabilities.screenResolutionY;
        appModel.appWidth = Capabilities.screenResolutionX;
        appModel.appheigth = Capabilities.screenResolutionY;
        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;*/
        //appModel.isFullscreen = true;

    }

}
}
