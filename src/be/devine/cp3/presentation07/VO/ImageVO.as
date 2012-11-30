package be.devine.cp3.presentation07.VO {
public class ImageVO {
    //PROPERTIES
    public var width:int = 0;
    public var height:int = 0;
    public var xpos:uint = 0;
    public var ypos:uint = 0;
    public var index:int = 0;
    public var path:String = '';

    //CONSTRUCTOR
    public function ImageVO(width:int, height:int, xpos:uint, ypos:int, index:int, path:String) {

        this.width = width;
        this.height = height;
        this.xpos = xpos;
        this.ypos = ypos;
        this.index = index;
        this.path = path;

    }
}
}
