package be.devine.cp3.presentation07.view {
import be.devine.cp3.presentation07.VO.DiaVO;
import be.devine.cp3.presentation07.model.AppModel;
import be.devine.cp3.presentation07.view.thumbnails.Thumbnail;

import flash.events.Event;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class ThumbnailView extends Sprite{
    //PROPERTIES
    private var appModel:AppModel;

    private var background:Quad;
    private var thumb:Thumbnail;
    private var backgroundThumb:Quad;

    //CONSTRUCTOR
    public function ThumbnailView() {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.XML_LOADED, xmlLoadedHandler);

        background  = new Quad(1024,683,0x585858);
        addChild(background);

        // Achtergrond van de thumbs
        backgroundThumb = new Quad(204, 154, 0x66b34e);
        backgroundThumb.x = 3;
        backgroundThumb.y = 3;
        addChild(backgroundThumb);

    }

    private function xmlLoadedHandler(event:flash.events.Event):void {
        trace('[THUMBNAILVIEW]: xml loaded');

        var xpos:uint = 5;
        var ypos:uint = 5;
        var count:int = 0;
        for each(var dia:DiaVO in appModel.xmlDataArray){
            var thumb:Thumbnail = new Thumbnail(dia);
            thumb.x = xpos;
            thumb.y = ypos;
            addChild(thumb);
            xpos+=210;
            count++;
            if(count == 4){
                ypos = 160;
                xpos = 5;
            }
        }
        
        
    }

    // Aanduiden van de actieve thumb



    // Eerst doorgeven welke thumb er wordt gekozen
    private function onTouchShowActive(event:TouchEvent):void{
        //Als je klikt
        if(event.getTouch(this, TouchPhase.ENDED)){
            trace ("[ThumbnailView]CurrentTarget " + event.currentTarget);
            var activeThumb:Thumbnail = event.currentTarget as Thumbnail;
            backgroundThumb.x = activeThumb.x - 2;
            backgroundThumb.y = activeThumb.y - 2;
        }
    }




}
}
