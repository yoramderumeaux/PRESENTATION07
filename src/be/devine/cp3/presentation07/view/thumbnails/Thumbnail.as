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

    //private var pixelMasker:PixelMaskDisplayObject;
    //CONSTRUCTOR
    public function Thumbnail(dia:DiaVO) {

        this.appModel = AppModel.getInstance();



        masker = new Quad(200,150,uint(dia.bgColor));
        addChild(masker);

        addChild(container);

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
            var tekstVeld:TextField = new TextField(780,580,tekst.tekst,tekst.fontName,tekst.fontSize,uint(tekst.color));
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


        container.scaleX = 0.25;
        container.scaleY = 0.25;

        //mask via een extensie class ( PixelMaskDisplayObject )
        var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
        maskedDisplayObject.addChild(container);

        maskedDisplayObject.mask = masker;
        addChild(maskedDisplayObject);

    }


}
}
