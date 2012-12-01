package be.devine.cp3.presentation07.components {
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class BulletsGroup extends Sprite{
    //PROPERTIES

    //CONSTRUCTOR
    public function BulletsGroup(items:Array, fontName:String, fontSize:int, color:String) {

        var yPos:int = 0;

        for each(var tekst:String in items){
            var tekstVeld:TextField = new TextField(780,580,tekst,fontName,fontSize,uint(color));
            tekstVeld.hAlign = HAlign.LEFT;
            tekstVeld.vAlign = VAlign.TOP;
            tekstVeld.y = yPos;
            addChild(tekstVeld);
            yPos += 20;
        }
    }
}
}
