package be.devine.cp3.presentation07.VO {
public class TekstVO {
    //PROPERTIES
    public var tekst:String = '';
    public var fontSize:int = 0;
    public var xpos:uint = 0;
    public var ypos:uint = 0;
    public var index:int = 0;
    public var horizontalCenter:Boolean = false;
    public var verticalCenter:Boolean = false;

    //CONSTRUCTOR
    public function TekstVO(tekst:String, fontSize:int, xpos:uint, ypos:uint, index:int, horizontalCenter:Boolean, verticalCenter:Boolean) {

        this.tekst = tekst;
        this.fontSize = fontSize;
        this.xpos = xpos;
        this.ypos = ypos;
        this.index = index;
        this.horizontalCenter = horizontalCenter;
        this.verticalCenter = verticalCenter;

    }
}
}
