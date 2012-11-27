package be.devine.cp3.presentation07.VO {
public class diaVO {
    //PROPERTIES
    public var bgImagePath:String = '';
    public var tekst:Array;
    public var images:Array;

    //CONSTRUCTOR
    public function diaVO(backgroundImagePath:String, tekst:Array, images:Array) {

        this.bgImagePath = backgroundImagePath;
        this.tekst = tekst;
        this.images = images;

    }
}
}
