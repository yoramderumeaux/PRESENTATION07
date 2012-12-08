package be.devine.cp3.presentation07 {

import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.services.XmlService;
import be.devine.cp3.presentation07.view.MenuView;
import be.devine.cp3.presentation07.view.PresentationView;
import be.devine.cp3.presentation07.view.ThumbnailView;

import flash.events.Event;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.KeyboardEvent;

public class Application extends starling.display.Sprite{
    //PROPERTIES
    private var appModel:AppModel;
    private var menuView:MenuView;
    private var thumbnailView:ThumbnailView;

    private var presentationView:PresentationView;
    private var backGround:Quad;

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
        appModel.addEventListener(AppModel.PRESENTATION_STARTED, startPresentationHandler);
        appModel.addEventListener(AppModel.PRESENTATION_STOPPED, stopPresentationHandler);
        appModel.addEventListener(AppModel.XML_LOADED, xmlLoadedHandler);

        thumbnailView = new ThumbnailView();
        thumbnailView.y = 85;
        addChild(thumbnailView);

        menuView = new MenuView();
        addChild(menuView);

        //xml initieel inladen
        var xmlService:XmlService = new XmlService("assets/xml/startPresentatie.xml");

        //eventlistener koppelen voor keyboard... controleer in functie of de presentatie bzig is of nie

    }

    private function xmlLoadedHandler(event:Event):void{
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);

    }

    private function startPresentationHandler(event:Event){
        //tonen van presentatieView nadat de app fullscreen ging
        trace('nu fullscreen');
        backGround = new Quad(appModel.appWidth, appModel.appheigth, 0x000000);
        addChild(backGround);
        presentationView = new PresentationView();
        presentationView.x = (appModel.appWidth >> 1) - (presentationView.diaWidth >> 1);
        addChild(presentationView);
    }

    private function stopPresentationHandler(event:Event){
        //verwijder presentatie
        trace("[application]: presentatie stopped");
        if(presentationView != null){
            presentationView.dispose();
            removeChild(presentationView);
            backGround.dispose();
            removeChild(backGround);
        }
    }

    private function keyBoardHandler(event:starling.events.KeyboardEvent):void{
        //keyboard events tijdens het presenteren
        trace(event.keyCode);
        if(appModel.isPlaying == true){
            switch (event.keyCode){
                case 39:
                    trace("right");
                    appModel.currentDia++;
                    break;

                case 37:
                    trace("left");
                    appModel.currentDia--;
                    break;
                case 32:
                    trace("space");
                    appModel.isPlaying = false;
                    break;
            }

        }else{
            switch (event.keyCode){
                case 32:
                    trace("space");
                    appModel.isPlaying = true;
                    break;
            }
        }

    }

}
}
