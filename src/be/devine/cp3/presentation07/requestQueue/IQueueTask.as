package be.devine.cp3.presentation07.requestQueue {
import flash.events.IEventDispatcher;

public interface IQueueTask extends IEventDispatcher{
    function start():void;
}
}
