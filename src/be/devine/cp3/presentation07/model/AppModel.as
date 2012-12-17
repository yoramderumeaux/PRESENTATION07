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
    public static const PRESENTATION_STARTED:String = "PRESENTATION_STARTED";
    public static const  PRESENTATION_STOPPED:String = "PRESENTATION_STOPPED";
    public static const DIA_CHANGED:String = "DIA_CHANGED";
    public static const THUMB_CHANGED:String = "THUMB_CHANGED";
    public static const STAGE_RESIZE:String = "STAGE_RESIZE";
    public static const TRANSITION_BUSY:String = "TRANSITION_BUSY";

    private var _xmlDataArray:Array;
    private var _isPlaying:Boolean = false;
    private var _transitionReady:Boolean = true;

    private var _currentDia:int = 2;

    private var _appWidth:int = 0;
    private var _appheigth:int = 0;

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
        if(_xmlDataArray != value){
            _xmlDataArray = value;
            dispatchEvent(new Event(XML_LOADED));
        }
    }

    public function get isPlaying():Boolean {
        return _isPlaying;
    }

    public function set isPlaying(value:Boolean):void {
        if(_isPlaying != value){
            _isPlaying = value;
        }
        if(_isPlaying == true){
            dispatchEvent(new Event(PRESENTATION_STARTED));
        }else{
            dispatchEvent(new Event(PRESENTATION_STOPPED));
        }
    }

    public function get appWidth():int {
        return _appWidth;
    }

    public function set appWidth(value:int):void {
        if(_appWidth != value){
            _appWidth = value;
            dispatchEvent(new Event(STAGE_RESIZE));
        }
    }

    public function get appheigth():int {
        return _appheigth;
    }

    public function set appheigth(value:int):void {
        if(_appheigth != value){
            _appheigth = value;
            dispatchEvent(new Event(STAGE_RESIZE));
        }
    }

    public function get currentDia():int {
        return _currentDia;
    }

    public function set currentDia(value:int):void {
        if(_currentDia != value){
            _currentDia = value;

            if(_currentDia < 0){
                _currentDia = 0;
            }
            if(_currentDia > _xmlDataArray.length -1){
                _currentDia = _xmlDataArray.length -1
            }
            trace("[current dia]" + _currentDia);
            dispatchEvent(new Event(DIA_CHANGED));

        }
    }

    public function get transitionReady():Boolean {
        return _transitionReady;
    }

    public function set transitionReady(value:Boolean):void {
        if(_transitionReady != value){
            trace('[APPMODEL] transitionReadySate: ' + _transitionReady);
            _transitionReady = value;
            dispatchEvent(new Event(TRANSITION_BUSY));
        }

    }
}
}

internal class Enforcer{};