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

    public function start():void{

        if (tasks.length>0){
            currentTask = tasks.shift();
            currentTask.addEventListener(Event.COMPLETE,currentTaskCompleteHandler);
            currentTask.start();
        }else{
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    public function stop():void{
        //code schrijven die in tasks, currentTask en completedtasks event listeners removed
        if(currentTask != null){
            currentTask.removeEventListener(Event.COMPLETE,currentTaskCompleteHandler);
            tasks.splice(0);
            completedTasks.splice(0);
            currentTask = null;
        }

        //arrays leegmaken, instellen currentTask op null
    }

    private function currentTaskCompleteHandler(event:Event):void {
        completedTasks.push(event.target);

        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,completedTasks.length,totalTasks));

        start();
    }
}
}
