// RV MP3 Player Event
// RimV: www.mymedia-art.com || trieuduchien@gmail.com 

package com.rimv.utils
{
	import flash.events.Event;
	
	public class RVmp3PlayerEvent extends Event
	{
		public static const NEXT_SONG:String = "next song";
		public static const PREVIOUS_SONG:String = "previous song";
		public static const FAST_FORWARD:String = "fast forward";
		public static const REWIND:String = "rewind";
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		public static const SOUND_MUTE:String = "sound mute";
		public static const SOUND_NORMAL:String = "sound normal";
		public static const CURRENT_PROGRESS:String = "current progress";
		
		private var _songIndex:Number = 0;
		private var _currentProgress:Number;
		
		public function get songIndex():Number
		{
			return _songIndex;
		} 
		
		public function RVmp3PlayerEvent(type:String, songIndex:Number, currentProgress:Number)
		{
			super(type, true);
			_songIndex = songIndex;
			_currentProgress = currentProgress;
		}
		
		public override function clone():Event
		{
			return new RVmp3PlayerEvent(type, _songIndex, _currentProgress);
		}
    }
}