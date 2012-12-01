package be.devine.cp3.presentation07.view.thumbnails {
import be.devine.cp3.presentation07.model.AppModel;

import starling.display.Quad;

import starling.display.Sprite;

public class Thumbnail extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    //CONSTRUCTOR
    public function Thumbnail() {

        this.appModel = AppModel.getInstance();

        var test:Quad = new Quad(100,100,0x0000ff);
        addChild(test);

    }
}
}
