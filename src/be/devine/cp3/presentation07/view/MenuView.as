package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;

import starling.display.Button;
import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class MenuView extends Sprite{
    //PROPERTIES
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
    //CONSTRUCTOR
    public function MenuView(){
        //groene achtergrond maken
        var background:Quad = new Quad(1024,85,0x66b34e);
        addChild(background);

        //titel displayen
        var titelTexture:Texture = atlas.getTexture("titel");
        var titelImage:Image = new Image(titelTexture);
        titelImage.x = (1024 >> 1) - (titelImage.width >> 1);
        titelImage.y = (85 >> 1) - (titelImage.height >> 1);
        container.addChild(titelImage);

        newXmlButton = new Button(atlas.getTexture('newXml'));
        newXmlButton.x = 121;
        newXmlButton.y = 29;
        newXmlButton.addEventListener(TouchEvent.TOUCH, onTouchNew);
        container.addChild(newXmlButton);

        playButton = new Button(atlas.getTexture('playFromStart'));
        playButton.x = 307;
        playButton.y = 29;
        playButton.addEventListener(TouchEvent.TOUCH, onTouchPlay);
        container.addChild(playButton);

        playFromCurrentButton = new Button(atlas.getTexture('playFromCurrentDia_small'));
        playFromCurrentButton.x = 687;
        playFromCurrentButton.y = 29;
        playFromCurrentButton.addEventListener(TouchEvent.TOUCH, onTouchPlayFromDia);
        container.addChild(playFromCurrentButton);

        //bij resize gewoon de container in het midden zetten... ook groene band mee resizen.
        addChild(container);
    }

    private function onTouchNew(event:TouchEvent):void{
        if(event.getTouch(newXmlButton, TouchPhase.HOVER)){
            ballonImage.x = (newXmlButton.x + (newXmlButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (newXmlButton.y + newXmlButton.height) + 5;
            addChild(ballonImage);
            infoTekst.text = "Load a new local dia";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 8 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            addChild(infoTekst);
        }else{
            removeChild(ballonImage);
            removeChild(infoTekst);
        }

        if(event.getTouch(this, TouchPhase.ENDED)){
            // event dispatchen om nieuwe xml in te laden
        }
    }

    private function onTouchPlay(event:TouchEvent):void{
        if(event.getTouch(playButton, TouchPhase.HOVER)){
            ballonImage.x = (playButton.x + (playButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (playButton.y + playButton.height) + 5;
            addChild(ballonImage);
            infoTekst.text = "Play from start";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 8 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            addChild(infoTekst);
        }else{
            removeChild(ballonImage);
            removeChild(infoTekst);
        }

        if(event.getTouch(this, TouchPhase.ENDED)){
            // event dispatchen om nieuwe xml in te laden
        }
    }

    private function onTouchPlayFromDia(event:TouchEvent):void{
        if(event.getTouch(playFromCurrentButton, TouchPhase.HOVER)){
            ballonImage.x = (playFromCurrentButton.x + (playFromCurrentButton.width >> 1)) - (ballonImage.width >> 1);
            ballonImage.y = (playFromCurrentButton.y + playFromCurrentButton.height) + 5;
            addChild(ballonImage);
            infoTekst.text = "Play from selected dia";
            infoTekst.x = ballonImage.x + ((ballonImage.width >> 1) - (infoTekst.width >>1));
            infoTekst.y = ballonImage.y + 8 + ((ballonImage.height >> 1) - (infoTekst.height >>1));
            addChild(infoTekst);
        }else{
            removeChild(ballonImage);
            removeChild(infoTekst);
        }

        if(event.getTouch(this, TouchPhase.ENDED)){
            // event dispatchen om nieuwe xml in te laden
        }
    }

}
}
