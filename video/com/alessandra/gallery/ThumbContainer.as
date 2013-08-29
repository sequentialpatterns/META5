package alessandra.gallery
{	
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	public class ThumbContainer extends MovieClip
	{
		public var nr:int = 0;
		public var l:Loader = new Loader();
		public function ThumbContainer()
		{
		
		}
		function incarca(fila:URLRequest, w:Number, h:Number, nrcur:int):void
		{
		nr = nrcur;	
		
		l.contentLoaderInfo.addEventListener(Event.COMPLETE, startListener);
		l.load(fila);
		function startListener (e:Event):void{
		
		l.x=0;
		l.y=0;
		l.scaleX=w/l.width;
		l.scaleY = h / l.height;
		addChild(l);
	
	
	
	}
//Loader

}
	}
}