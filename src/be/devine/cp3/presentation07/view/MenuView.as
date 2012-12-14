package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.model.AppModel;

import flash.events.Event;

import starling.display.Button;
import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Stage;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class MenuView extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    //atlas van spriteSheet aanmaken
    private var texture:Texture = Texture.fromBitmap(new Application.uiTexture());
    private var xml:XML = XML(new Application.uiXml());
    private var atlas:TextureAtlas = new TextureAtlas(texture,xml);

    private var newXmlButton:Button;
    private var playButton:Button;
    private var playFromCurrentButton:Button;

    private var ballonTexture:Texture = atlas.getTexture("helpBalloon");
    private var ballonImage:Image = new Image(ballonTexture);
    private var infoTekst:TextField = new TextField(90,40,"",'Helvetica',15,0x66b34e);

    private var container:Sprite = new Sprite();
    private var background:Quad;
    //CONSTRUCTOR
    public function MenuView(){
        this.appModel = AppModel.getInstance();

        //Knoppen pas activeren als de xml is ingeladen
        appModel.addEventListener(AppModel.XML_LOADED, xmlLoadedHandler);
        appModel.addEventListener(AppModel.STAGE_RESIZE, resizeHandler);

        //groene achtergrond maken
        background = new Quad(appModel.appWidth,85,0x66b34e);
        addChild(background);

        //titel displayen
        var titelTexture:Texture = atlas.getTexture("titel");
        var titelImage:Image = new Image(titelTexture);
        titelImage.x = (1024 >> 1) - (titelImage.width >> 1);
        titelImage.y = (85 >> 1) - (titelImage.height >> 1);
        container.addChild(titelImage);

        //buttons aanmaken
        newXmlButton = new Button(atlas.getTexture('newXml'));
        newXmlButton.x = 121;
        newXmlButton.y = 29;
        container.addChild(newXmlButton);

        playButton = new Button(atlas.getTexture('playFromStart'));
        playButton.x = 307;
        playButton.y = 29;
        container.addChild(playButton);

        playFromCurrentButton = new Button(atlas.getTexture('playFromCurrentDia_small'));
        playFromCurrentButton.x = 687;
        playFromCurrentButton.y = 29;
        container.addChild(playFromCurrentButton);

        //bij resize gewoon de container in het midden zetten... ook groene band mee resizen.
        addChild(container);

    }

    private function xmlLoadedHandler(e:flash.events.Event):void{
        newXmlButton.addEventListener(TouchEvent.TOUCH, onTouchNew);
        playButton.addEventListener(TouchEvent.TOUCH, onTouchPlay);
        playFromCurrentButton.addEventListener(TouchEvent.TOUCH, onTouchPlayFromDia);
    }

    // Laadt een nieuwe XML in
    private function onTouchNew(event:TouchEvent):void{
        if(event.getTouch(newXmlButton, TouchPhase.HOVER)){

            ballonImage.x = (newXmlButton.x + (newXmlButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (newXmlButton.y + newXmlButton.height) + 5;
            container.addChild(ballonImage);
            infoTekst.text = "Load a new presentation";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 4 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            container.addChild(infoTekst);

        }else{
            container.removeChild(ballonImage);
            container.removeChild(infoTekst);
        }

        if(event.getTouch(this, TouchPhase.ENDED)){
            // event dispatchen om nieuwe xml in te laden
        }
    }

    // Play van het begin
    private function onTouchPlay(event:TouchEvent):void{
        if(event.getTouch(playButton, TouchPhase.HOVER)){
            ballonImage.x = (playButton.x + (playButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (playButton.y + playButton.height) + 5;
            container.addChild(ballonImage);
            infoTekst.text = "Play from start";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 4 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            container.addChild(infoTekst);
        }else{
            container.removeChild(ballonImage);
            container.removeChild(infoTekst);
        }

        //Als je klikt
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.currentDia = 0;
            appModel.isPlaying = true;
        }
    }

    // PLay from current dia
    private function onTouchPlayFromDia(event:TouchEvent):void{

        if(event.getTouch(playFromCurrentButton, TouchPhase.HOVER)){
            ballonImage.x = (playFromCurrentButton.x + (playFromCurrentButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (playFromCurrentButton.y + playFromCurrentButton.height) + 5;
            container.addChild(ballonImage);
            infoTekst.text = "Play from selected dia";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 4 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            container.addChild(infoTekst);
        }else{
            container.removeChild(ballonImage);
            container.removeChild(infoTekst);
        }

        //Als je klikt
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.isPlaying = true;
        }
    }

    private function resizeHandler(event:flash.events.Event):void{
        trace("resize");
        background.width = appModel.appWidth;
        container.x = ((appModel.appWidth >> 1) - (container.width >> 1)) - 210;
    }


}
}
