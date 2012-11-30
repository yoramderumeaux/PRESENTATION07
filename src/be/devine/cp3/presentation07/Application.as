package be.devine.cp3.presentation07 {
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.Queue;
import be.devine.cp3.presentation07.requestQueue.URLLoaderTask;
import be.devine.cp3.presentation07.view.MenuView;

import flash.events.Event;

import starling.display.Sprite;

public class Application extends starling.display.Sprite{
    //PROPERTIES
    private var appModel:AppModel;
    private var menuView:MenuView;

    private var xmlQueue:Queue;

    [Embed(source="../../../../assets/spriteSheets/uiElements.xml", mimeType="application/octet-stream")]
    public static const uiXml:Class;
    [Embed(source="../../../../assets/spriteSheets/uiElements.png")]
    public static const uiTexture:Class;
    [Embed(source="../../../../assets/fonts/Abel-Regular.ttf", embedAsCFF="false", fontFamily="Abel")]
    private static const Abel:Class;
    [Embed(source="../../../../assets/fonts/Helvetica.ttf", embedAsCFF="false", fontFamily="Helvetica")]
    private static const Helvetica:Class;

    //CONSTRUCTOR
    public function Application(){

        trace('[APPLICATION] ready for use');

        appModel = AppModel.getInstance();

        menuView = new MenuView();
        addChild(menuView);

        //initieel ophalen van de xml
        xmlQueue = new Queue();
        xmlQueue.Add(new URLLoaderTask("assets/xml/testDia.xml"));
        xmlQueue.addEventListener(Event.COMPLETE, xmlLoadedHandler);
        xmlQueue.Start();
    }

    public function xmlLoadedHandler(event:Event):void{
        var xmlTask:URLLoaderTask = xmlQueue.completedTasks[0] as URLLoaderTask;
        var diaXml:XML = new XML(xmlTask.data);

        var diasArray:Array = new Array();

        // DATA in value objects steken en in een array.. dat we gemakkelijk aan de data kunnen.
        for each(var diaNode:XML in diaXml.dia){
            var tekstArray:Array = new Array();
            var imageArray:Array = new Array();

            trace("/// " + diaNode.@number + " ///");

            for each(var textNode:XML in diaNode.text){
                var tekst:TekstVO = new TekstVO(textNode, textNode.@fontsize, textNode.@xpos, textNode.@ypos, textNode.@index, textNode.@horizontalCenter, textNode.@verticalCenter);
                tekstArray.push(tekst);
            }

            for each(var imageNode:XML in diaNode.image){
                var images:ImageVO = new ImageVO(imageNode.@width, imageNode.@height, imageNode.@xpos, imageNode.@ypos, imageNode.@index, imageNode);
                imageArray.push(images);
            }

            //trace('testje ophalen data' + tekstArray[0].xpos);
            var dias:DiaVO = new DiaVO(diaNode.backgroundImage, tekstArray, imageArray);

            diasArray.push(dias);

        }

        appModel.xmlDataArray = diasArray;
    }
}
}
