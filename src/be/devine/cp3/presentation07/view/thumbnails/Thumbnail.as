package be.devine.cp3.presentation07.view.thumbnails {
import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.components.BulletsGroup;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.ImageLoaderTask;
import be.devine.cp3.presentation07.requestQueue.Queue;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.DisplayObject;

import flash.display.Loader;

import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Button;


import starling.display.Image;

import starling.display.Quad;

import starling.display.Sprite;
import be.devine.cp3.presentation07.extensions.pixelmask.PixelMaskDisplayObject;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;
import starling.textures.RenderTexture;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Thumbnail extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var container:Sprite = new Sprite();
    private var masker:Quad;

    private var _id:int;

    private var groenVierkant:Quad;
    private var overlay:Quad = new Quad(200,150,0x000000);

    private var imageQueue:Queue;
    private var imageDataArray:Array = new Array();

    private var dia:DiaVO;

    private var textArray:Array = new Array();
    private var imagesArray:Array = new Array();
    private var bulletsGroupArray:Array = new Array();

    private var texture:Texture = Texture.fromBitmap(new Application.uiTexture());
    private var xml:XML = XML(new Application.uiXml());
    private var atlas:TextureAtlas = new TextureAtlas(texture,xml);

    private var playFromCurrentButton:Button;
    private var playTexture:Texture = atlas.getTexture("playFromCurrentDia_small");
    private var playImage:Image = new Image(playTexture);

    //CONSTRUCTOR
    public function Thumbnail(dia:DiaVO) {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.DIA_CHANGED, showActive);
        this._id  = dia.id;
        this.dia = dia;

        masker = new Quad(200,150,uint(dia.bgColor));
        addChild(masker);

        imageQueue = new Queue();

        for each(var image:ImageVO in dia.images){
            imageDataArray.push(new Array(image.width,image.height,image.xpos, image.ypos));
            //images laden via de requestQueue
            imageQueue.Add(new ImageLoaderTask(image.path));
        }
        imageQueue.addEventListener(Event.COMPLETE, imagesComplete);
        imageQueue.start();

        if(dia.images.length == 0){
            restOfDia();
        }
    }

    private function imagesComplete(e:Event):void{
        for(var i:uint = 0; imageQueue.completedTasks.length > i; i++){
            if(imageQueue.completedTasks[i] is DisplayObject){
                var images:DisplayObject = imageQueue.completedTasks[i];
                var bd:BitmapData = new BitmapData(images.width, images.height, true,0xFFFFFFFF);
                bd.draw(images);
                var b:Bitmap = new Bitmap(bd);

                var displayedImage:Image = Image.fromBitmap(b);
                displayedImage.width = imageDataArray[i][0];
                displayedImage.height = imageDataArray[i][1];
                displayedImage.x = imageDataArray[i][2];
                displayedImage.y = imageDataArray[i][3];
                container.addChild(displayedImage);
                imagesArray.push(displayedImage);
            }
        }
        restOfDia();
    }

    private function restOfDia():void{

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
            textArray.push(tekstVeld);
        }

        for each(var bullets:BulletsVO in dia.bullets){
            var bulletsGroup:BulletsGroup = new BulletsGroup(bullets.bullets,bullets.fontName,bullets.fontSize,bullets.color);
            bulletsGroup.x = bullets.xpos;
            bulletsGroup.y = bullets.ypos;
            container.addChild(bulletsGroup);
            bulletsGroupArray.push(bulletsGroup);
        }

        //de container 4 keer kleiner maken voor een thumbnail te creeeren
        container.scaleX = 0.25;
        container.scaleY = 0.25;

        var renderTexture:RenderTexture = new RenderTexture(masker.width,masker.height);
        renderTexture.draw(container);
        var diaImage:Image = new Image(renderTexture);
        addChild(diaImage);
        diaImage.addEventListener(TouchEvent.TOUCH, hoverHandler);

        if(textArray.length > 0){
            for each(var tekstData:TextField in textArray){
                tekstData.dispose();
                removeChild(tekstData);
            }
            textArray.splice(0);
        }

        if(imagesArray.length > 0){
            for each(var imageData:Image in imagesArray){
                imageData.dispose();
                removeChild(imageData);
            }
            imagesArray.splice(0);
        }

        if(bulletsGroupArray.length > 0){
            for each(var bulletsData:BulletsGroup in bulletsGroupArray){
                bulletsData.disposeTextField();
                bulletsData.dispose();
                removeChild(bulletsData);
            }
            bulletsGroupArray.splice(0);
        }
        if(container != null){
            container.dispose();
            removeChild(container);
        }
    }

    private function hoverHandler(event:TouchEvent):void{
        if(event.getTouch(this, TouchPhase.ENDED)){
            appModel.currentDia = _id;
        }
    }

    private function showActive(event:Event):void{
        if(this._id == (appModel.currentDia)){
            groenVierkant = new Quad(204,154,0x66b34e);
            groenVierkant.x = -2;
            groenVierkant.y = -2;
            addChildAt(groenVierkant,0);
        }else{
            if( groenVierkant != null){
                groenVierkant.dispose();
                removeChild(groenVierkant);
            }
        }
    }

    public function get id():int {
        return _id;
    }

    public function set id(value:int):void {
        _id = value;
    }
}
}