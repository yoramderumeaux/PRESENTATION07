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

import starling.display.Button;
import starling.display.Quad;

import starling.display.Sprite;
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



    // ***********************
    //      Constructor
    // ***********************
    public function MenuSlideView() {

        this.appModel = AppModel.getInstance();
        infoContainer = new Sprite();

        // Next button aanmaken
        nextSlide = new Button(atlas.getTexture('nextSlide'));
        nextSlide.x = 50;
        nextSlide.y = (appModel.appheigth - nextSlide.height) /2;
        addChild(nextSlide);

        // Previous button aanmaken
        previousSlide = new Button(atlas.getTexture('previousSlide'));
        previousSlide.x = appModel.appWidth - 50 - previousSlide.width;
        previousSlide.y = (appModel.appheigth - previousSlide.height) /2;
        addChild(previousSlide);

        // Quit Presentation
        stopBackground = new Quad(286, 84, 0x000000, 59);
        stopBackground.x = 0;
        stopBackground.y = 0;
        infoContainer.addChild(stopBackground);

        stopPresentation = new TextField(286,84,"Stop presentation",'Abel',30,0xFFFFFF);
        stopPresentation.x = 0;
        stopPresentation.y = 0;
        infoContainer.addChild(stopPresentation);

        // Slide Count
        countBackground = new Quad(286, 84, 0x000000, 59);
        countBackground.x = 300;
        countBackground.y = 0;
        infoContainer.addChild(countBackground);

        slideCount = new TextField(286,84,"Slide " + (appModel.currentDia + 1),'Abel',30,0xFFFFFF);
        slideCount.x = 300;
        slideCount.y = 0;
        infoContainer.addChild(slideCount);

        addChild(infoContainer);
        infoContainer.x = (appModel.appWidth - infoContainer.width) / 2;
        infoContainer.y = (appModel.appheigth - infoContainer.height);


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
            trace ("[MENUSLIDEVIEW] Ik stop de presentatie met de QUIT PRESENTATION - button");
            appModel.isPlaying = false;
        }
    }

    private function onTouchPreviousSlide(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            trace ("[MENUSLIDEVIEW] ga naar de vorige slide met de button");
            appModel.currentDia --;
        }
    }

    private function onTouchNextSlide(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            trace ("[MENUSLIDEVIEW] ga naar de volgende slide met de button");
            appModel.currentDia ++;
        }
    }
}
}
