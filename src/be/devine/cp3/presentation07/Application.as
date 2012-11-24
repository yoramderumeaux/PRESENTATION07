package be.devine.cp3.presentation07 {
import be.devine.cp3.presentation07.model.AppModel;

import flash.display.Sprite;

public class Application extends Sprite{
    //PROPERTIES

    //CONSTRUCTOR
    public function Application(){
        trace('[APPLICATION] loaded after pre-loading');

        var appModel:AppModel = new AppModel();
    }
}
}
