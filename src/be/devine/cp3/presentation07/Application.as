package be.devine.cp3.presentation07 {

import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.services.XmlService;
import be.devine.cp3.presentation07.view.MenuSlideView;
import be.devine.cp3.presentation07.view.MenuView;
import be.devine.cp3.presentation07.view.PresentationView;
import be.devine.cp3.presentation07.view.ThumbnailView;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;

public class Application extends starling.display.Sprite{
    //PROPERTIES
    private var appModel:AppModel;
    private var menuView:MenuView;
    private var thumbnailView:ThumbnailView;
    private var options:MenuSlideView;

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
        appModel.addEventListener(AppModel.TRANSITION_BUSY, transitionKeyboardHandler);

        thumbnailView = new ThumbnailView();
        thumbnailView.y = 85;
        addChild(thumbnailView);

        menuView = new MenuView();
        addChild(menuView);

        //xml initieel inladen
        var xmlService:XmlService = new XmlService("assets/xml/startPresentatie.xml");
    }

    private function xmlLoadedHandler(event:Event):void{
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardUPHandler);
    }

    private function startPresentationHandler(event:Event):void{
        //tonen van presentatieView nadat de app fullscreen ging
        backGround = new Quad(appModel.appWidth, appModel.appheigth, 0x000000);
        addChild(backGround);
        presentationView = new PresentationView();
        presentationView.x = (appModel.appWidth >> 1) - (presentationView.diaWidth >> 1);
        addChild(presentationView);

        options = new MenuSlideView();
        addChild(options);

        addEventListener(TouchEvent.TOUCH, onTouchShowMenu);
    }

    private function onTouchShowMenu(event:TouchEvent):void{
        options.onTouchShowMenu(null);
    }

    private function stopPresentationHandler(event:Event):void{
        //verwijder presentatie
        trace("[application]: presentatie stopped");
        if(presentationView != null){
            presentationView.clearData();

            presentationView.dispose();
            removeChild(presentationView);
            backGround.dispose();
            removeChild(backGround);
        }
        if(options != null){
            options.dispose();
            removeChild(options);
        }
    }

    private function keyBoardHandler(event:starling.events.KeyboardEvent):void{
        //keyboard events tijdens het presenteren
        trace("[APPLICATION] Er wordt een key ingeduwd");
        if(appModel.isPlaying == true){
            switch (event.keyCode){
                case 39:
                    trace("[APPLICATION]: right");
                    appModel.currentDia++;
                    break;

                case 37:
                    trace("[APPLICATION]: left");
                    appModel.currentDia--;
                    break;
                case 32:
                    trace("[APPLICATION]: space");
                    appModel.isPlaying = false;
                    break;
            }

        }else{
            switch (event.keyCode){
                case 32:
                    trace("[APPLICATION]: space");
                    stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
                    appModel.isPlaying = true;
                    break;
            }
        }

    }

    private function keyBoardUPHandler(event:starling.events.KeyboardEvent):void{
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
    }

    private function transitionKeyboardHandler(event:Event):void{
        if(appModel.transitionReady == false){
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
            stage.removeEventListener(KeyboardEvent.KEY_UP, keyBoardUPHandler);
        }else{
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardUPHandler);
        }
    }

}
}
