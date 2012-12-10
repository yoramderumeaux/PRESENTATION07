package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.Application;
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.view.thumbnails.Thumbnail;

import flash.events.Event;

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


    //private var thumb:Thumbnail;
    //private var backgroundThumb:Quad;

    //CONSTRUCTOR
    public function ThumbnailView() {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.XML_LOADED, xmlLoadedHandler);
        appModel.addEventListener(AppModel.STAGE_RESIZE, resizeHandler);

        background  = new Quad(appModel.appWidth,683,0x585858);
        addChild(background);

        thumbContainer = new Sprite();
        addChild(thumbContainer);

        // Achtergrond van de thumbs
       /* backgroundThumb = new Quad(204, 154, 0x66b34e);
        backgroundThumb.x = 3;
        backgroundThumb.y = 3;
        addChild(backgroundThumb);*/

    }

    private function xmlLoadedHandler(event:flash.events.Event):void {
        trace('[THUMBNAILVIEW]: xml loaded');

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
            /*count++;
            if(count == 4){
                ypos += 160;
                xpos = 5;
                count = 0;
            }  */

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
                pageText.text = "Slide " + 1*page + " - " + 12*page ;
                pageText.x = 10;
                pageContainer.addChild(pageText);


                pageContainer.x = (background.width - pageContainer.width) /2;
                pageContainer.y = 35;


                //pageContainer.addChild(thumbContainer);
                addChild(pageContainer);
            }

        }
        //begindia tonen als active
        appModel.currentDia = 0;

        thumbContainer.x = (background.width - (4*thumb.width)) / 2;
        thumbContainer.y = (background.height - thumbContainer.height) / 2 ;


    }


    private function onTouchnextPage(event:TouchEvent):void{
       if(event.getTouch(this, TouchPhase.ENDED)){


           page ++;

            // Vanaf je 1 keer naar de volgende pagina bent geweest kan je pas naar de vorige pagina
            previousPage.addEventListener(TouchEvent.TOUCH, onTouchPreviousPage);
            thumbContainer.x -= 860;
           pageText.text = "Slide " + 1*page + " - " + 12*page ;
           trace ("[Thumbnailview]: Next Page + Pagenumber = " + page);
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
           pageText.text = "Slide " + 1*page + " - " + 12*page ;

           trace ("[Thumbnailview]: Previous Page + Pagenumber = " + page);

       }
    }

    // Aanduiden van de actieve thumb



    // Eerst doorgeven welke thumb er wordt gekozen
   /* private function onTouchShowActive(event:TouchEvent):void{
        //Als je klikt
        if(event.getTouch(this, TouchPhase.ENDED)){
            trace ("[ThumbnailView]CurrentTarget " + event.currentTarget);
            var activeThumb:Thumbnail = event.currentTarget as Thumbnail;
            backgroundThumb.x = activeThumb.x - 2;
            backgroundThumb.y = activeThumb.y - 2;
        }
    }*/

    private function resizeHandler(event:Event):void{
        background.width = appModel.appWidth;
        background.height = appModel.appheigth;
        pageContainer.x = (appModel.appWidth >> 1) - (pageContainer.width >> 1);
        thumbContainer.x = (appModel.appWidth >> 1) - (thumbContainer.width >> 2) + 5;
        //thumbContainer.x = (background.width - (4*thumb.width)) / 2;
    }




}
}
