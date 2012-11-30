package {

import be.devine.cp3.presentation07.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import starling.core.Starling;


public class Main extends Sprite {
    //PROPERTIES
    private var starling:Starling;

    //CONSTRUCTOR
    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;

        starling = new Starling(Application,stage);
        starling.start();
    }

}
}
