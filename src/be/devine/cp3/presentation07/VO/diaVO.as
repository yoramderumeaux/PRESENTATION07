package be.devine.cp3.presentation07.VO {
public class DiaVO {
    //PROPERTIES
    public var bgColor:String = '';
    public var tekst:Array;
    public var images:Array;
    public var bullets:Array;
    public var id:int;

    //CONSTRUCTOR
    public function DiaVO(backgroundColor:String, tekst:Array, images:Array, bullets:Array, id:int) {

        this.bgColor = backgroundColor;
        this.tekst = tekst;
        this.images = images;
        this.bullets = bullets;
        this.id = id;
    }
}
}
