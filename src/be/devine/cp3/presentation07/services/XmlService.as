package be.devine.cp3.presentation07.services {
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.Queue;
import be.devine.cp3.presentation07.requestQueue.URLLoaderTask;

import flash.events.Event;

import flash.events.EventDispatcher;

public class XmlService extends EventDispatcher{
    //PROPERTIES
    private var appModel:AppModel;
    private var xmlQueue:Queue;

    //CONSTRUCTOR
    public function XmlService(xmlPath:String) {
        this.appModel = AppModel.getInstance();

        xmlQueue = new Queue();
        xmlQueue.Add(new URLLoaderTask(xmlPath));
        xmlQueue.addEventListener(Event.COMPLETE, xmlLoadedHandler);
        xmlQueue.start();

    }

    private function xmlLoadedHandler(event:Event):void{
        var xmlTask:URLLoaderTask = xmlQueue.completedTasks[0] as URLLoaderTask;
        var diaXml:XML = new XML(xmlTask.data);

        var diasArray:Array = new Array();

        // DATA in value objects steken en in een array.. dat we gemakkelijk aan de data kunnen.
        for each(var diaNode:XML in diaXml.dia){
            var tekstArray:Array = new Array();
            var imageArray:Array = new Array();
            //array voor alle bulletObjecten in dia
            var bulletsArray:Array = new Array();
            //array voor alle bulletItems in de BulletObjecten
            var bulletsTextArray:Array = new Array();

            //trace("/// " + diaNode.@id + " ///");

            for each(var textNode:XML in diaNode.text){
                var tekst:TekstVO = new TekstVO(textNode, textNode.@fontname,textNode.@fontsize, textNode.@xpos, textNode.@ypos, textNode.@color,textNode.@index, textNode.@horizontalCenter, textNode.@verticalCenter);
                tekstArray.push(tekst);
                trace(diaNode.text);
            }

            for each(var imageNode:XML in diaNode.image){
                var images:ImageVO = new ImageVO(imageNode.@width, imageNode.@height, imageNode.@xpos, imageNode.@ypos, imageNode.@index, imageNode);
                imageArray.push(images);
            }

            for each(var bulletsNode:XML in diaNode.bullets){
                for each(var bulletTextNode:XML in bulletsNode.bullet){
                    bulletsTextArray.push(bulletTextNode);
                }
                var bullets:BulletsVO = new BulletsVO(bulletsTextArray,bulletsNode.@fontname, bulletsNode.@fontsize, bulletsNode.@xpos, bulletsNode.@ypos, bulletsNode.@color, bulletsNode.@index);
                bulletsArray.push(bullets);
            }

            var dias:DiaVO = new DiaVO(diaNode.backgroundColor, tekstArray, imageArray, bulletsArray, diaNode.@id, diaNode.transition);

            diasArray.push(dias);

        }

        appModel.xmlDataArray = diasArray;
    }
}
}
