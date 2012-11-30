package be.devine.cp3.presentation07.VO {
public class DiaVO {
    //PROPERTIES
    public var bgImagePath:String = '';
    public var tekst:Array;
    public var images:Array;

    //CONSTRUCTOR
    public function DiaVO(backgroundImagePath:String, tekst:Array, images:Array) {

        this.bgImagePath = backgroundImagePath;
        this.tekst = tekst;
        this.images = images;

    }
}
}
