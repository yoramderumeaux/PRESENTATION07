/**
 * Created with IntelliJ IDEA.
 * User: Jones
 * Date: 15/12/12
 * Time: 15:53
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.model.AppModel;

import flash.events.Event;

import flash.events.TimerEvent;

import flash.utils.Timer;

import starling.display.Button;
import starling.display.Quad;

import starling.display.Sprite;
import starling.display.Stage;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class MenuSlideView extends Sprite{

    // ***********************
    //      PROPERTIES
    // ***********************

    private var appModel:AppModel;

    // Aanmaken atlas van spritesheet
    private var texture:Texture = Texture.fromBitmap(new Application.uiTexture());
    private var xml:XML = XML(new Application.uiXml());
    private var atlas:TextureAtlas = new TextureAtlas(texture,xml);

    // Buttons aanmaken
    private var nextSlide:Button;
    private var previousSlide:Button;
    private var stopPresentation:TextField;
    private var slideCount:TextField = new TextField(90,15,"Slide 1/24",'Helvetica',15,0x66b34e);
    private var stopBackground:Quad;
    private var countBackground:Quad;

    private var infoContainer:Sprite;
    private var myTimer:Timer;

    // ***********************
    //      Constructor
    // ***********************
    public function MenuSlideView() {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.DIA_CHANGED, updateTextField);
        appModel.addEventListener(AppModel.TRANSITION_BUSY, transitionKeyboardHandler);
        infoContainer = new Sprite();

        // Next button aanmaken
        nextSlide = new Button(atlas.getTexture('nextSlide'));
        nextSlide.x = 50;
        nextSlide.y = (appModel.appheigth - nextSlide.height) /2;

        // Previous button aanmaken
        previousSlide = new Button(atlas.getTexture('previousSlide'));
        previousSlide.x = appModel.appWidth - 50 - previousSlide.width;
        previousSlide.y = (appModel.appheigth - previousSlide.height) /2;

        // Quit Presentation
        stopBackground = new Quad(286, 84, 0x000000, 59);
        stopBackground.x = 0;
        stopBackground.y = 0;

        stopPresentation = new TextField(286,84,"Stop presentation",'Abel',30,0xFFFFFF);
        stopPresentation.x = 0;
        stopPresentation.y = 0;

        // Slide Count
        countBackground = new Quad(286, 84, 0x000000, 59);
        countBackground.x = 300;
        countBackground.y = 0;

        slideCount = new TextField(286,84,"Slide " + (appModel.currentDia + 1),'Abel',30,0xFFFFFF);
        slideCount.x = 300;
        slideCount.y = 0;

        myTimer = new Timer(3000, 1);
        myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);

        // Toevoegen van Event Listeners

        // Stoppen met de presentatie
        stopBackground.addEventListener(TouchEvent.TOUCH, onTouchStopPresentation);
        stopPresentation.addEventListener(TouchEvent.TOUCH, onTouchStopPresentation);

        // Previous slide
        nextSlide.addEventListener(TouchEvent.TOUCH, onTouchPreviousSlide);
        previousSlide.addEventListener(TouchEvent.TOUCH, onTouchNextSlide);
    }


    // ***********************
    //      Functies
    // ***********************

    private function onTouchStopPresentation(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.isPlaying = false;
        }
    }

    private function onTouchPreviousSlide(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.currentDia --;
        }
    }

    private function onTouchNextSlide(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.currentDia ++;
        }
    }

    private function updateTextField(event:Event):void{
        slideCount.text = "Slide " + (appModel.currentDia + 1);
    }

    private function timerCompleteHandler(event:TimerEvent):void{
        removeChild(nextSlide);
        removeChild(previousSlide);
        infoContainer.removeChild(stopBackground);
        infoContainer.removeChild(countBackground);
        infoContainer.removeChild(slideCount);
        infoContainer.removeChild(stopPresentation);
        removeChild(infoContainer);
    }

    public function onTouchShowMenu(event:TouchEvent):void{
        if(myTimer != null){
            addChild(nextSlide);
            addChild(previousSlide);
            infoContainer.addChild(stopBackground);
            infoContainer.addChild(countBackground);
            infoContainer.addChild(slideCount);
            infoContainer.addChild(stopPresentation);
            addChild(infoContainer);
            infoContainer.x = (appModel.appWidth - infoContainer.width) / 2;
            infoContainer.y = (appModel.appheigth - infoContainer.height);

            myTimer.start();
        }
    }

    private function transitionKeyboardHandler(event:Event):void{
        if(appModel.transitionReady == false){
            nextSlide.removeEventListener(TouchEvent.TOUCH, onTouchPreviousSlide);
            previousSlide.removeEventListener(TouchEvent.TOUCH, onTouchNextSlide);
        }else{
            nextSlide.addEventListener(TouchEvent.TOUCH, onTouchPreviousSlide);
            previousSlide.addEventListener(TouchEvent.TOUCH, onTouchNextSlide);
        }
    }

}
}
