package be.devine.cp3.presentation07.model {
import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher{
    //PROPERTIES
    private static var instance:AppModel;

    public static function getInstance():AppModel{
        if(instance == null){
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public static const XML_LOADED:String = "XML_LOADED";

    private var _xmlDataArray:Array;

    //CONSTRUCTOR
    public function AppModel(e:Enforcer) {

        if(e == null){
            throw new Error('AppModel is a Singleton');
        }

    }

    public function get xmlDataArray():Array {
        return _xmlDataArray;
    }

    public function set xmlDataArray(value:Array):void {
        _xmlDataArray = value;
        trace('[APPMODEL]:' + xmlDataArray[1].tekst[0].xpos);
        dispatchEvent(new Event(XML_LOADED));
    }
}
}

internal class Enforcer{};
