package be.devine.cp3.presentation07 {
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.Queue;
import be.devine.cp3.presentation07.requestQueue.URLLoaderTask;
import be.devine.cp3.presentation07.services.XmlService;
import be.devine.cp3.presentation07.view.MenuView;
import be.devine.cp3.presentation07.view.PresentationView;
import be.devine.cp3.presentation07.view.ThumbnailView;

import flash.events.Event;

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.KeyboardEvent;

public class Application extends starling.display.Sprite{
    //PROPERTIES
    private var appModel:AppModel;
    private var menuView:MenuView;
    private var thumbnailView:ThumbnailView;

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
        appModel.addEventListener(AppModel.IS_FULLSCREEN, startPresentationHandler);

        thumbnailView = new ThumbnailView();
        thumbnailView.y = 85;
        addChild(thumbnailView);

        menuView = new MenuView();
        addChild(menuView);

        //xml initieel inladen
        var xmlService:XmlService = new XmlService("assets/xml/startPresentatie.xml");
    }

    private function startPresentationHandler(event:Event){
        //tonen van presentatieView nadat de app fullscreen ging
        trace('nu fullscreen');
        var pre:PresentationView = new PresentationView();
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
        addChild(pre);
    }

    private function keyBoardHandler(event:starling.events.KeyboardEvent):void{
        //keyboard events tijdens het presenteren
        trace(event.keyCode);
        switch (event.keyCode){
            case 39:
                    trace("right");
                    appModel.currentDia++;
                break;

            case 37:
                    trace("left");
                    appModel.currentDia--;
                break;
        }
    }

}
}
