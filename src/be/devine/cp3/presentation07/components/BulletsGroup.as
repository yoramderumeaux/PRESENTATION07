package be.devine.cp3.presentation07.components {
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class BulletsGroup extends Sprite{
    //PROPERTIES
    private var tekstVeldArray:Array = new Array();
    //CONSTRUCTOR
    public function BulletsGroup(items:Array, fontName:String, fontSize:int, color:String) {

        var yPos:int = 0;

        for each(var tekst:String in items){
            var tekstVeld:TextField = new TextField(750,500,"×  " + tekst,fontName,fontSize,uint(color));
            tekstVeld.hAlign = HAlign.LEFT;
            tekstVeld.vAlign = VAlign.TOP;
            tekstVeld.y = yPos;
            addChild(tekstVeld);
            yPos += fontSize + 10;
        }
    }

    public function disposeTextField():void{
        if(tekstVeldArray.length > 0){
            for each(var tekstData:TextField in tekstVeldArray){
                tekstData.dispose();
                removeChild(tekstData);
            }
            tekstVeldArray.splice(0);
        }
    }
}
}
