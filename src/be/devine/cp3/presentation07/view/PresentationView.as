package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;
import starling.display.Button;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.components.BulletsGroup;
import be.devine.cp3.presentation07.extensions.pixelmask.PixelMaskDisplayObject;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.requestQueue.ImageLoaderTask;
import be.devine.cp3.presentation07.requestQueue.Queue;
import be.devine.cp3.presentation07.requestQueue.URLLoaderTask;
import be.devine.cp3.presentation07.view.dias.Dia;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.Event;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.RenderTexture;
import starling.textures.SubTexture;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class PresentationView extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var container:Sprite;

    private var masker:Quad;
    private var ratio:Number;

    private var dia:DiaVO;

    public var diaWidth:int;

    private var imageQueue:Queue;
    private var imageDataArray:Array = new Array();

    private var textArray:Array = new Array();
    private var imagesArray:Array = new Array();
    private var bulletsGroupArray:Array = new Array();
    private var textureArray:Array = new Array();
    private var diaImageArray:Array = new Array();
    private var transitionMaskArray:Array = new Array();

    private var options:MenuSlideView;

    //atlas van spriteSheet aanmaken
    private var texture:Texture = Texture.fromBitmap(new Application.uiTexture());
    private var xml:XML = XML(new Application.uiXml());
    private var atlas:TextureAtlas = new TextureAtlas(texture,xml);

    //CONSTRUCTOR
    public function PresentationView() {
        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.DIA_CHANGED, changeDiaHandler);

        options = new MenuSlideView();

        renderDia();

    }

    //METHODS
    private function changeDiaHandler(event:Event):void{
        renderDia();
    }

    private function calculateDiaWidth():int{
        return ((appModel.appheigth/3) * 4);
    }

    private function calculateRatio():Number{
        return ((appModel.appheigth/600));
    }

    private function renderDia():void{

        //SET TRANSITION STATE
        appModel.transitionReady = false;

        //nieuwe dia maken
        dia = appModel.xmlDataArray[appModel.currentDia];

        container = new Sprite();

        diaWidth = calculateDiaWidth();
        ratio = calculateRatio();

        masker = new Quad(diaWidth,appModel.appheigth,uint(dia.bgColor));
        container.addChild(masker);

        imageQueue = new Queue();

        for each(var image:ImageVO in dia.images){
            imageDataArray.push(new Array(image.width,image.height,image.xpos, image.ypos));
            imageQueue.Add(new ImageLoaderTask(image.path));
        }

        if(dia.images.length == 0){
            restOfDia();
        }else{
            imageQueue.addEventListener(Event.COMPLETE, imagesComplete);
            imageQueue.start();
        }
    }

    private function imagesComplete(e:Event):void{
       for(var i:uint = 0; imageQueue.completedTasks.length > i; i++){
            if(imageQueue.completedTasks[i] is DisplayObject){
                var images:DisplayObject = imageQueue.completedTasks[i];
                var bd:BitmapData = new BitmapData(images.width, images.height, true,0xFFFFFFFF);
                bd.draw(images);
                var b:Bitmap = new Bitmap(bd);

                if(imageDataArray[i] != null){
                    var displayedImage:Image = Image.fromBitmap(b);
                    displayedImage.width = imageDataArray[i][0] * ratio;
                    displayedImage.height = imageDataArray[i][1] * ratio;
                    displayedImage.x = imageDataArray[i][2] * ratio;
                    displayedImage.y = imageDataArray[i][3] * ratio;
                    container.addChild(displayedImage);
                    //displayedImage.dispose();
                    imagesArray.push(displayedImage);
                }

            }
        }
        restOfDia();
    }

    private function restOfDia():void{
        for each(var tekst:TekstVO in dia.tekst){
            var tekstVeld:TextField = new TextField(700 * ratio,300 * ratio,tekst.tekst,tekst.fontName,tekst.fontSize*ratio,uint(tekst.color));
            tekstVeld.hAlign = HAlign.LEFT;
            tekstVeld.vAlign = VAlign.TOP;

            if(tekst.horizontalCenter == "true"){
                tekstVeld.hAlign = HAlign.CENTER;
                tekstVeld.x = (diaWidth >> 1) - (tekstVeld.width >> 1);
            }else{
                tekstVeld.x = tekst.xpos * ratio;
            }

            if(tekst.verticalCenter == "true"){
                tekstVeld.vAlign = VAlign.CENTER;
                tekstVeld.y = (appModel.appheigth >> 1) - (tekstVeld.height >> 1);
            }else{
                tekstVeld.y = tekst.ypos * ratio;
            }
            container.addChild(tekstVeld);
            textArray.push(tekstVeld);
        }

        for each(var bullets:BulletsVO in dia.bullets){
            var bulletsGroup:BulletsGroup = new BulletsGroup(bullets.bullets,bullets.fontName,bullets.fontSize*ratio,bullets.color);
            bulletsGroup.x = bullets.xpos * ratio;
            bulletsGroup.y = bullets.ypos * ratio;
            container.addChild(bulletsGroup);
            bulletsGroupArray.push(bulletsGroup);
        }

        //addChild(container);

        var renderTexture:RenderTexture = new RenderTexture(masker.width,masker.height);
        renderTexture.draw(container);
        textureArray.push(renderTexture);
        var diaImage:Image = new Image(renderTexture);
        addChild(diaImage);
        diaImageArray.push(diaImage);

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
        if(masker != null){
            masker.dispose();
            removeChild(masker);
        }
        if(container != null){
            container.dispose();
            removeChild(container);
        }
        if(imageDataArray != null){
            imageDataArray.splice(0);
        }



        if(dia.transition == 'fade'){
            diaImage.alpha = 0;
            var tween:Tween = new Tween(diaImage, 1, Transitions.EASE_IN_OUT);
            tween.fadeTo(1);    // equivalent to 'animate("alpha", 0)'
            Starling.juggler.add(tween);
        }
        if(dia.transition == 'inschuiven'){
            diaImage.y = appModel.appheigth;
            var tween:Tween = new Tween(diaImage, 1,Transitions.EASE_IN_OUT);
            tween.animate("y", 0);
            Starling.juggler.add(tween);
        }
        if(dia.transition == 'hoekTransitie'){

            var transitionsMasker:Quad = new Quad(diaWidth,appModel.appheigth,0xff00ff);
            transitionsMasker.x = -diaWidth;
            transitionsMasker.y = -appModel.appheigth;

            var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
            maskedDisplayObject.addChild(diaImage);
            maskedDisplayObject.mask = transitionsMasker;
            addChild(maskedDisplayObject);

            var tween:Tween = new Tween(transitionsMasker, 1,Transitions.EASE_IN_OUT);
            tween.animate("x", 0);
            tween.animate("y", 0);
            Starling.juggler.add(tween);

            transitionMaskArray.push(transitionsMasker);
            transitionMaskArray.push(maskedDisplayObject);
        }
        tween.onComplete = clearPreviousDia;
    }

    private function clearPreviousDia():void{
        if(diaImageArray.length >= 2){

            var deleteDiaTexture = textureArray.shift();
            var deleteDiaImage = diaImageArray.shift();

            var diaTextureData:RenderTexture = deleteDiaTexture as RenderTexture;
            diaTextureData.dispose();

            var diaImageData:Image = deleteDiaImage as Image;
            diaImageData.dispose();
            removeChild(diaImageData);

            if(transitionMaskArray.length >= 3){
                var deleteQuad = transitionMaskArray.shift();
                var deletMask = transitionMaskArray.shift();

                var quadData:Quad = deleteQuad as Quad;
                quadData.dispose();
                removeChild(quadData);

                var maskData:PixelMaskDisplayObject = deletMask as PixelMaskDisplayObject;
                maskData.dispose();
                removeChild(maskData);
            }
        }


        appModel.transitionReady = true;
    }

    public function clearData():void{

        if(imageQueue != null){
            imageQueue.stop();
        }

        for(var i:uint = 0; transitionMaskArray.length > i; i++){
            if(transitionMaskArray[i] is Quad){
                var quads:Quad = transitionMaskArray[i];
                quads.dispose();
                removeChild(quads);
            }
            if(transitionMaskArray[i] is PixelMaskDisplayObject){
                var mask:PixelMaskDisplayObject = transitionMaskArray[i];
                mask.dispose();
                removeChild(mask);
            }
        }

        for each(var textures:RenderTexture in textureArray){
            textures.dispose();
        }
        for each(var images:Image in diaImageArray){
            images.dispose();
            removeChild(images);
        }
    }

}
}
