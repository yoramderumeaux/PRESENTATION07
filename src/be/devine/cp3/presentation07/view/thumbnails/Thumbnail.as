package be.devine.cp3.presentation07.view.thumbnails {
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.components.BulletsGroup;
import be.devine.cp3.presentation07.model.AppModel;

import flash.display.Loader;

import flash.events.Event;
import flash.net.URLRequest;


import starling.display.Image;

import starling.display.Quad;

import starling.display.Sprite;
import be.devine.cp3.presentation07.extensions.pixelmask.PixelMaskDisplayObject;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Thumbnail extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var container:Sprite = new Sprite();
    private var masker:Quad;
    private var imageWidth:int;
    private var imageHeigth:int;
    private var imageXPos:uint;
    private var imageYPos:uint;
    private var id:int;

    private var overlay:Quad = new Quad(800,600,0x000000);
    private var hoverField:Quad = new Quad(200,150,0x00ff00);
    //private var pixelMasker:PixelMaskDisplayObject;
    //CONSTRUCTOR
    public function Thumbnail(dia:DiaVO) {

        this.appModel = AppModel.getInstance();
        this.id  = dia.id;

        masker = new Quad(200,150,uint(dia.bgColor));
        addChild(masker);

        //hover event toevoegen
        container.addEventListener(TouchEvent.TOUCH, hoverHandler);
        addChild(container);

        //Alle elementen ophalen en plaatsen op de dia
        for each(var image:ImageVO in dia.images){
            var img:Quad = new Quad(image.width,image.height,0xff00ff);
            img.x = image.xpos;
            img.y = image.ypos;
            container.addChild(img);
            this.imageWidth = image.width;
            this.imageHeigth = image.height;
            this.imageXPos = image.xpos;
            this.imageYPos = image.ypos;

            //images laden via de requestQueue
        }


        for each(var tekst:TekstVO in dia.tekst){
            var tekstVeld:TextField = new TextField(700,540,tekst.tekst,tekst.fontName,tekst.fontSize,uint(tekst.color));
            tekstVeld.hAlign = HAlign.LEFT;
            tekstVeld.vAlign = VAlign.TOP;

            if(tekst.horizontalCenter == "true"){
                tekstVeld.hAlign = HAlign.CENTER;
                tekstVeld.x = (800 >> 1) - (tekstVeld.width >> 1);
            }else{
                tekstVeld.x = tekst.xpos;
            }

            if(tekst.verticalCenter == "true"){
                tekstVeld.vAlign = VAlign.CENTER;
                tekstVeld.y = (600 >> 1) - (tekstVeld.height >> 1);
            }else{
                tekstVeld.y = tekst.ypos;
            }
            container.addChild(tekstVeld);
        }

        for each(var bullets:BulletsVO in dia.bullets){
            var bulletsGroup:BulletsGroup = new BulletsGroup(bullets.bullets,bullets.fontName,bullets.fontSize,bullets.color);
            bulletsGroup.x = bullets.xpos;
            bulletsGroup.y = bullets.ypos;
            container.addChild(bulletsGroup);
        }

        //de container 4 keer kleiner maken voor een thumbnail te creeeren
        container.scaleX = 0.25;
        container.scaleY = 0.25;

        //mask via een extensie class ( PixelMaskDisplayObject )
        var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
        maskedDisplayObject.addChild(container);

        maskedDisplayObject.mask = masker;
        addChild(maskedDisplayObject);


    }

    private function hoverHandler(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.HOVER)){
            overlay.alpha = 0.7;
            container.addChild(overlay);
            //image toevoegen van playfromCurrentDia
        }else{
            container.removeChild(overlay);
        }

        if(event.getTouch(this, TouchPhase.ENDED)){
            //currentDia aanpassen
            //nog visueel weergeven dat deze dia de current is
            appModel.currentDia = id;
        }
    }


}
}
