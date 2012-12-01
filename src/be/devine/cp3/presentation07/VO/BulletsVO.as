package be.devine.cp3.presentation07.VO {
public class BulletsVO {
    //PROPERTIES
    public var fontName:String = '';
    public var fontSize:int = 0;
    public var xpos:uint = 0;
    public var ypos:uint = 0;
    public var color:String = '';
    public var index:int = 0;
    public var bullets:Array = new Array();

    //CONSTRUCTOR
    public function BulletsVO(bullets:Array, fontName:String, fontSize:int,  xpos:uint, ypos:uint, color:String, index:int) {

        this.bullets = bullets;
        this.fontName = fontName;
        this.fontSize = fontSize;
        this.xpos = xpos;
        this.ypos = ypos;
        this.color = color;
        this.index = index;
    }
}
}
