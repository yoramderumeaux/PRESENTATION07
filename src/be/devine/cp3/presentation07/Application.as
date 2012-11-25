package be.devine.cp3.presentation07 {
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.Queue;
import be.devine.cp3.presentation07.requestQueue.URLLoaderTask;

import flash.display.Sprite;
import flash.events.Event;

public class Application extends Sprite{
    //PROPERTIES
    private var xmlQueue:Queue;

    //CONSTRUCTOR
    public function Application(){
        trace('[APPLICATION] loaded after pre-loading');

        var appModel:AppModel = new AppModel();

        xmlQueue = new Queue();
        xmlQueue.Add(new URLLoaderTask("assets/xml/testDia.xml"));
        xmlQueue.addEventListener(Event.COMPLETE, xmlLoadedHandler);
        xmlQueue.Start();
    }

    public function xmlLoadedHandler(event:Event):void{
        var xmlTask:URLLoaderTask = xmlQueue.completedTasks[0] as URLLoaderTask;
        var diaXml:XML = new XML(xmlTask.data);

        for each(var diaNode:XML in diaXml.dia){
            trace("/// " + diaNode.@number + " ///");
            trace(diaNode.backgroundImage);

            for each(var textNode:XML in diaNode.text){
               trace(textNode);
            }

            for each(var imageNode:XML in diaNode.image){
                trace(imageNode);
            }

        }

    }
}
}
