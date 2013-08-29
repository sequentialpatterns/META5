package alessandra.gallery
{	
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	public class Container extends MovieClip
	{
		public var description:String = "a"
		public var nr:int = 0;
		public var l:Loader = new Loader();
		public function Container()
		{
		
		}
		function incarca(fila:URLRequest,des:String, loader_mc:MovieClip, w:Number, h:Number, nrcur:int,bar:MovieClip):void
		{
		nr = nrcur;	
		description = des;
		loader_mc.visible = true;
		loader_mc.x = w / 2;
		loader_mc.y = h / 2;
		addChild(loader_mc)
		addChild(l);
		//function to load the given URL
		l.contentLoaderInfo.addEventListener(Event.COMPLETE, startListener);
		l.load(fila);
		function startListener (e:Event):void{
		var rect:Shape = new Shape();
		rect.graphics.beginFill(0xFFFFFF);
		rect.graphics.drawRect(0, 0, w, h);
		rect.graphics.endFill();
		bar.visible = true;
		loader_mc.visible = false;
		removeChild(loader_mc) ;
		l.mask=rect;
		l.x=0;
		l.y=0;
		l.scaleX=w/l.width;
		l.scaleY=h/l.height;
	
	
	
	}
//Loader

}
	}
}