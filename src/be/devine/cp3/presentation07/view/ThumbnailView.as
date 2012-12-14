package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.extensions.pixelmask.PixelMaskDisplayObject;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.view.thumbnails.Thumbnail;

import flash.events.Event;
import flash.geom.Rectangle;

import starling.display.Button;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class ThumbnailView extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var background:Quad;
    private var thumbContainer:Sprite;
    private var pageContainer:Sprite;

    private var texture:Texture = Texture.fromBitmap(new Application.uiTexture());
    private var xml:XML = XML(new Application.uiXml());
    private var atlas:TextureAtlas = new TextureAtlas(texture,xml);

    private var nextPage:Button;
    private var previousPage:Button;
    private var pageText:TextField;
    private var page:int;
    private var pagesTotal:int;
    private var endSlidesNumber:int;

    private var mask:Quad;
    private var maskedDisplayObject:PixelMaskDisplayObject;
    //CONSTRUCTOR
    public function ThumbnailView() {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.XML_LOADED, xmlLoadedHandler);
        appModel.addEventListener(AppModel.STAGE_RESIZE, resizeHandler);

        background  = new Quad(appModel.appWidth,appModel.appheigth-85,0x585858);
        addChild(background);

        thumbContainer = new Sprite();
        addChild(thumbContainer);

    }

    private function xmlLoadedHandler(event:flash.events.Event):void {
        trace('[THUMBNAILVIEW]: xml loaded');

        pagesTotal = Math.ceil((appModel.xmlDataArray.length - 1)/12);

        var xpos:uint = 5;
        var ypos:uint = 5;
        var count:int = 0;

        // Op page ga je weten op welke pagina je zit en moet de xpositie van thumbnail container mee worden vermenigvuldigd
        page = 1;

        for each(var dia:DiaVO in appModel.xmlDataArray){
            var thumb:Thumbnail = new Thumbnail(dia);
            thumb.x = xpos;
            thumb.y = ypos;
            thumbContainer.addChild(thumb);
            xpos+=210;

            count = thumb.id + 1;
            // Om de 4 een nieuwe rij begonnen
            if(count %4 == 0){
                ypos += 160;
                xpos -= 840;
            }
            // Om de 12 een nieuwe pagina beginnen
            if(count %12 == 0){
                ypos = 5;
                xpos += 860;
            }
            if (count == 13){

                pageContainer = new Sprite();

                previousPage = new Button(atlas.getTexture("previousPage"));
                previousPage.y = 2;
                pageContainer.addChild(previousPage);


                nextPage = new Button(atlas.getTexture("nextPage"));
                nextPage.x = 102;
                nextPage.y = 2;
                nextPage.addEventListener(TouchEvent.TOUCH, onTouchnextPage);

                pageContainer.addChild(nextPage);

                pageText = new TextField(90, 15 ,"",'Abel',15,0xFFFFFF);
                trace("sommetje: "+  uint( ((12*page)-(appModel.xmlDataArray.length)) )  );
                endSlidesNumber = ((12*page)-(appModel.xmlDataArray.length-1));
                if(endSlidesNumber < 0){
                    endSlidesNumber = 0;
                }
                pageText.text = "Slide " + (((page-1)*12)+1) + " - " + ((12*page)- endSlidesNumber) ;
                pageText.x = 10;
                pageContainer.addChild(pageText);


                pageContainer.x = (background.width - pageContainer.width) /2;
                pageContainer.y = 35;

                addChild(pageContainer);
            }

        }
        //begindia tonen als active
        appModel.currentDia = 0;

        thumbContainer.x = (appModel.appWidth >> 1) - (thumbContainer.width >> 2);
        thumbContainer.y = (background.height - thumbContainer.height) / 2 ;

        /*mask = new Quad(840,600,0xff0000);
        mask.x = thumbContainer.x;
        mask.y = thumbContainer.y;

        maskedDisplayObject = new PixelMaskDisplayObject();
        maskedDisplayObject.addChild(thumbContainer);
        maskedDisplayObject.mask = mask;
        addChild(maskedDisplayObject);*/
    }


    private function onTouchnextPage(event:TouchEvent):void{
       if(event.getTouch(this, TouchPhase.ENDED)){

           if(pagesTotal != page){
               page ++;
               // Vanaf je 1 keer naar de volgende pagina bent geweest kan je pas naar de vorige pagina
               previousPage.addEventListener(TouchEvent.TOUCH, onTouchPreviousPage);
               thumbContainer.x -= 860;
               endSlidesNumber = ((12*page)-(appModel.xmlDataArray.length));
               if(endSlidesNumber < 0){
                   endSlidesNumber = 0;
               }
               pageText.text = "Slide " + (((page-1)*12)+1) + " - " + ((12*page)-endSlidesNumber) ;
           }

       }
    }

    private function onTouchPreviousPage(event:TouchEvent):void{
       if(event.getTouch(this, TouchPhase.ENDED)){

           page --;
           // Wanneer je terug op de eerste pagina bent, kan je niet meer meer terug.
           if (page == 1){
               previousPage.removeEventListener(TouchEvent.TOUCH, onTouchPreviousPage);
           }

           thumbContainer.x += 860;
           endSlidesNumber = ((12*page)-(appModel.xmlDataArray.length));
           if(endSlidesNumber < 0){
               endSlidesNumber = 0;
           }
           pageText.text = "Slide " + (((page-1)*12)+1) + " - " + ((12*page)-endSlidesNumber);
       }
    }

    private function resizeHandler(event:Event):void{
        background.width = appModel.appWidth;
        background.height = appModel.appheigth-85;
        pageContainer.x = (appModel.appWidth >> 1) - (pageContainer.width >> 1);
        thumbContainer.x = (appModel.appWidth >> 1) - (thumbContainer.width >> 2);
        //mask.x = thumbContainer.x;
        //mask.y = thumbContainer.y;

        //maskedDisplayObject.x = (appModel.appWidth >> 1) - (thumbContainer.width >> 2) + 5;
       // thumbContainer.x = (background.width - (4*thumb.width)) / 2;
    }




}
}
