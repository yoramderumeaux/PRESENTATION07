package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.VO.BulletsVO;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.VO.ImageVO;
import be.devine.cp3.presentation07.VO.TekstVO;
import be.devine.cp3.presentation07.components.BulletsGroup;
import be.devine.cp3.presentation07.extensions.pixelmask.PixelMaskDisplayObject;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.view.dias.Dia;


import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;


import starling.display.Quad;

import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class PresentationView extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var container:Sprite;
    private var img:Quad;
    private var tekstVeld:TextField;
    private var bulletsGroup:BulletsGroup;
    private var maskedDisplayObject:PixelMaskDisplayObject;

    private var dia:DiaVO;

    public var diaWidth:int;

    //CONSTRUCTOR
    public function PresentationView() {
        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.DIA_CHANGED, changeDiaHandler);

        showDia();

    }

    private function changeDiaHandler(event:Event):void{
        showDia();
    }

    //dia opmaken
    private function showDia():void{

        renderDia();

    }

    private function calculateDiaWidth():int{
        return ((appModel.appheigth/3) * 4);
    }

    private function calculateRatio():Number{
        return ((appModel.appheigth/600));
    }

    private function renderDia():void{

        //clearen van memory
        if(bulletsGroup != null){
            trace("[bulletsGroup]: remove");
            bulletsGroup.dispose();
            removeChild(bulletsGroup);
        }
        if(img != null){
            trace("[img]: remove");
            img.dispose();
            removeChild(img);
        }
        if(tekstVeld != null){
            trace("[tekstVeld]: remove");
            tekstVeld.dispose();
            removeChild(tekstVeld);
        }
        if(container != null){
            trace("[container]: remove");
            container.dispose();
            removeChild(container);
        }
        if(maskedDisplayObject != null){
            trace("[maskedDisplayObject]: remove");
            maskedDisplayObject.dispose();
            removeChild(maskedDisplayObject);
        }

        //nieuwe dia maken
        dia = appModel.xmlDataArray[appModel.currentDia];

        container = new Sprite();
        var masker:Quad;

        diaWidth = calculateDiaWidth();
        var ratio:Number = calculateRatio();

        masker = new Quad(diaWidth,appModel.appheigth,uint(dia.bgColor));
        container.addChild(masker);

        for each(var image:ImageVO in dia.images){
            img = new Quad(image.width * ratio,image.height * ratio,0xff00ff);
            img.x = image.xpos * ratio;
            img.y = image.ypos * ratio;
            container.addChild(img);
            /*this.imageWidth = image.width;
             this.imageHeigth = image.height;
             this.imageXPos = image.xpos;
             this.imageYPos = image.ypos;*/

            //images laden via de requestQueue
        }



        for each(var tekst:TekstVO in dia.tekst){
            tekstVeld = new TextField(700 * ratio,540 * ratio,tekst.tekst,tekst.fontName,tekst.fontSize*ratio,uint(tekst.color));
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
        }

        for each(var bullets:BulletsVO in dia.bullets){
            bulletsGroup = new BulletsGroup(bullets.bullets,bullets.fontName,bullets.fontSize*ratio,bullets.color);
            bulletsGroup.x = bullets.xpos * ratio;
            bulletsGroup.y = bullets.ypos * ratio;
            container.addChild(bulletsGroup);
        }


        //mask via een extensie class ( PixelMaskDisplayObject )
        maskedDisplayObject = new PixelMaskDisplayObject();
        maskedDisplayObject.addChild(container);

        maskedDisplayObject.mask = masker;
        addChild(maskedDisplayObject);

        container.flatten();

        //in het midden plaatsen van de dia tijdens presentatie... Nog even achterwege laten.
        //container.x = (appModel.appWidth >> 1) - (container.width >> 1);

    }


}
}
