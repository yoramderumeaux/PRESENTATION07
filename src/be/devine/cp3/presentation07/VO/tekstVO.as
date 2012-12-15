package be.devine.cp3.presentation07.VO {
public class TekstVO {
    //PROPERTIES
    public var tekst:String = '';
    public var fontName:String = '';
    public var fontSize:int = 0;
    public var xpos:uint = 0;
    public var ypos:uint = 0;
    public var color:String = '';
    public var index:int = 0;
    public var horizontalCenter:String = "";
    public var verticalCenter:String = "";

    //CONSTRUCTOR
    public function TekstVO(tekst:String, fontName:String ,fontSize:int, xpos:uint, ypos:uint, color:String, index:int, horizontalCenter:String, verticalCenter:String) {

        this.tekst = tekst;
        this.fontName = fontName;
        this.fontSize = fontSize;
        this.xpos = xpos;
        this.ypos = ypos;
        this.color = color;
        this.index = index;
        this.horizontalCenter = horizontalCenter;
        this.verticalCenter = verticalCenter;

        //github refresh?
    }
}
}
