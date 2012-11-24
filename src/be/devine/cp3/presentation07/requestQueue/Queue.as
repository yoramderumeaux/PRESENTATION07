package be.devine.cp3.presentation07.requestQueue {
import flash.display.Loader;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

public class Queue extends EventDispatcher{
    //PROPERTIES
    private var tasks:Array = new Array();
    private var currentTask:IQueueTask;

    public var completedTasks:Array = new Array();
    private var totalTasks:uint;

    //CONSTRUCTOR
    public function Queue() {
        totalTasks = 0;
    }

    public function Add(task:IQueueTask):void{
        tasks.push(task);
        totalTasks++;
    }

    public function Start():void{

        if (tasks.length>0){
            currentTask = tasks.shift();
            currentTask.addEventListener(Event.COMPLETE,currentTaskCompleteHandler);
            currentTask.start();
        }else{
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function currentTaskCompleteHandler(event:Event):void {
        completedTasks.push(event.target);

        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,completedTasks.length,totalTasks));

        Start();
    }
}
}
