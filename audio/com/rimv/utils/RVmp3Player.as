// RV MP3 Player
// RimV: www.mymedia-art.com || trieuduchien@gmail.com 

package com.rimv.utils	{
	
	import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.*;
	import flash.text.TextField;
		
	public class RVmp3Player extends Sprite
	{
		// Song informations
		private var _songTitleList:Array = [];
		private var _songURLList:Array = [];
		private var _songDescriptionList:Array = [];
		private var _songLengthList:Array = [];
		
		// attributes
		private var _volume:Number = 1;
		private var _autoPlay:Boolean = false;
		private var _dragAble:Boolean = true;
		private var _scrollingSpeed:Number = 0.5;
		private var _ffStep:Number = 10;
		private var _bufferTime:Number = 5000;
				
		// Main sounds object
		private var _sound:Sound = new Sound();
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		private var _soundLoaderContext:SoundLoaderContext = new SoundLoaderContext();
		
		// misc variable
		private var _currentSongIndex:Number = 0;
		private var _currentSongProgress:Number = 0;
		private var _soundState:String = "Normal";
		private var _playState:String = "Pause";
		private var _soundLength:Number;
		private var isPlaying:Boolean = false;
		private var  descriptionArea:TextField = new TextField();
		private var pBar:MovieClip = new MovieClip();
		private var _loaded:Number;
		private var _total:Number;
		private var mp3Loaded:Boolean = false;
		private var maxPosition:Number = 0;		
		//_______________________________________________GET and SET PROPERTIES
		
		// Song URL List
		public function get songURLList():Array
		{
			return _songURLList;
		}
		
		public function set songURLList(a:Array):void
		{
			_songURLList = a;
		}
		
		// Song Title
		public function get songTitleList():Array
		{
			return _songTitleList;
		}
		
		public function set songTitleList(a:Array):void
		{
			_songTitleList = a;
		}
				
		// Song Description
		public function get songDescriptionList():Array
		{
			return _songDescriptionList;
		}
		
		public function set songDescriptionList(a:Array):void
		{
			_songDescriptionList = a;
		}
		
		// Song Length
		public function get songLengthList():Array
		{
			return _songLengthList;
		}
		
		public function set songLengthList(a:Array):void
		{
			_songLengthList = a;
		}
		
		// Volume
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(n:Number):void
		{
			_volume = n;
		}
		
		// Auto play
		public function get autoPlay():Boolean
		{
			return _autoPlay;
		}
		
		public function set autoPlay(b:Boolean):void
		{
			_autoPlay = b;
		}
		
		// Dragable
		public function get dragAble():Boolean
		{
			return _dragAble;
		}
		
		public function set dragAble(b:Boolean):void
		{
			_dragAble = b;
		}
		
		// Scrolling Speed
		public function get scrollingSpeed():Number
		{
			return _scrollingSpeed;
		}
		
		public function set scrollingSpeed(n:Number):void
		{
			_scrollingSpeed = n;
		}
		
		// Buffer time
		public function get bufferTime():Number
		{
			return _bufferTime;
		}
		
		public function set bufferTime(n:Number):void
		{
			_bufferTime = n;
		}
		
				
		// RVmp3Player Constructor
		public function RVmp3Player()
		{
			// Initialize event of control buttons
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, playButtonPress);
			pauseButton.addEventListener(MouseEvent.MOUSE_DOWN, pauseButtonPress);
			rewindButton.addEventListener(MouseEvent.MOUSE_DOWN, rewindButtonPress);
			ffButton.addEventListener(MouseEvent.MOUSE_DOWN, ffButtonPress);
			nextButton.addEventListener(MouseEvent.MOUSE_DOWN, nextButtonPress);
			previousButton.addEventListener(MouseEvent.MOUSE_DOWN, previousButtonPress);
			stopButton.addEventListener(MouseEvent.MOUSE_DOWN, stopButtonPress);
			soundButton.addEventListener(MouseEvent.MOUSE_DOWN, soundButtonPress);
			muteButton.addEventListener(MouseEvent.MOUSE_DOWN, muteButtonPress);
			progressBar.seekArea.addEventListener(MouseEvent.MOUSE_DOWN, seekProgressBar);
			dragComponent.addEventListener(MouseEvent.MOUSE_DOWN, dragPlayer);
			dragComponent.addEventListener(MouseEvent.MOUSE_UP,unDragPlayer);
			closePlayer.addEventListener(MouseEvent.MOUSE_DOWN, close);
			
			// misc initalization
			descriptionArea = descriptionClip.descriptionArea;
			pBar = progressBar.pBar;
			songTime.visible = false;
		}
		
		//_____________________________________________ IMPLEMENT BUTTON FUNCTION
		// Play
		private function playButtonPress(e:Event):void
		{
			// Perform simple fading
			swapButtonDepth();
			pauseButton.alpha = 0;
			Tweener.addTween(pauseButton,{	alpha:1,
											time:1
										});
			Tweener.addTween(playButton,{	alpha:0,
											time:1
										});
										
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.PAUSE, _currentSongIndex, _currentSongProgress));			_soundChannel = _sound.play(_currentSongProgress);
			_soundChannel.soundTransform = _soundTransform;
			isPlaying = true;
			pBar.addEventListener(Event.ENTER_FRAME, updatePosition);
		}
		
		// Pause
		private function pauseButtonPress(e:Event):void
		{
			// Perform simple fading
			swapButtonDepth();
			playButton.alpha = 0;
			Tweener.addTween(playButton,{	alpha:1,
											time:1
										});
			
			Tweener.addTween(pauseButton,{	alpha:0,
											time:1
										});
										
			_currentSongProgress = _soundChannel.position;
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.PLAY, _currentSongIndex, _currentSongProgress));
			if (isPlaying) 
			{
				isPlaying = false;
				_soundChannel.stop();	
			}										
		}
		
		// Rewind
		private function rewindButtonPress(e:Event):void
		{
			if (isPlaying)
			{
				_soundChannel.stop();
				_currentSongProgress = 0;
				_soundChannel = _sound.play(_currentSongProgress);
				_soundChannel.soundTransform = _soundTransform;
			}
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.REWIND, _currentSongIndex, _currentSongProgress));	
		}
		
		// Fast forward
		private function ffButtonPress(e:Event):void
		{
			if (isPlaying)
			{
				_currentSongProgress = _soundChannel.position + _ffStep * 1000;
				if (_currentSongProgress > _songLengthList[_currentSongIndex]) 
					_currentSongProgress = _songLengthList[_currentSongIndex]
				else
				{
					_soundChannel.stop();
					_soundChannel = _sound.play(_currentSongProgress);
					_soundChannel.soundTransform = _soundTransform;
				}
			}
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.FAST_FORWARD, _currentSongIndex, _currentSongProgress));	
		}
		
		// Next
		private function nextButtonPress(e:Event):void
		{
			_soundChannel.stop();
			if (_currentSongIndex == songURLList.length - 1) playSong(0); else playSong(_currentSongIndex + 1);
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.NEXT_SONG, _currentSongIndex, _currentSongProgress));	
		}
		
		// Previous
		private function previousButtonPress(e:Event):void
		{
			_soundChannel.stop();
			if (_currentSongIndex == 0) playSong(songURLList.length - 1); else playSong(_currentSongIndex - 1);
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.PREVIOUS_SONG, _currentSongIndex, _currentSongProgress));	
		}
		
		// Stop
		private function stopButtonPress(e:Event):void
		{
			stopSong();
			if (getChildIndex(pauseButton) > getChildIndex(playButton)) swapButtonDepth();
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.STOP, _currentSongIndex, _currentSongProgress));	
		}
		
		// Sound
		private function soundButtonPress(e:Event):void
		{
			// Perform simple fading
			var soundDepth:Number = getChildIndex(soundButton);
			var muteDepth:Number = getChildIndex(muteButton);
			setChildIndex(soundButton, muteDepth);
			setChildIndex(muteButton, soundDepth);
			muteButton.alpha = 0;
			Tweener.addTween(muteButton,{	alpha:1,
											time:1
										});
			Tweener.addTween(soundButton,{	alpha:0,
											time:1
										});
			soundFadeOut();		
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.SOUND_NORMAL, _currentSongIndex, _currentSongProgress));
		}
		
		// Mute
		private function muteButtonPress(e:Event):void
		{
			// Perform simple fading
			var soundDepth:Number = getChildIndex(soundButton);
			var muteDepth:Number = getChildIndex(muteButton);
			setChildIndex(soundButton, muteDepth);
			setChildIndex(muteButton, soundDepth);
			soundButton.alpha = 0;
			Tweener.addTween(muteButton,{	alpha:0,
											time:1
										});
			Tweener.addTween(soundButton,{	alpha:1,
											time:1
										});
			soundFadeIn();
			dispatchEvent(new RVmp3PlayerEvent(RVmp3PlayerEvent.SOUND_MUTE, _currentSongIndex, _currentSongProgress));
		}
		
		private function close(e:Event):void
		{
			stopSong();
			//if (contains(this)) this.parent.removeChild(this);
		}
		
		//_____________________________________________ IMPLEMENT CONTROL FUNCTION
		
		// load and play new song
		public function playSong(index:Number):void
		{
			stopSong();
			_currentSongIndex = index;
			_currentSongProgress = 0;
			maxPosition = 0;
			mp3Loaded = false;
			pBar.scaleX = 0;
			_sound = new Sound();
			_soundLoaderContext.bufferTime = _bufferTime;
			_sound.load(new URLRequest(songURLList[index]),_soundLoaderContext);
			_soundChannel = _sound.play(0);
			if (_soundTransform != null) 
				_soundChannel.soundTransform = _soundTransform;
			else 
				_soundTransform = _soundChannel.soundTransform;
			if (getChildIndex(pauseButton) < getChildIndex(playButton)) swapButtonDepth();
			// update song title
			songTitleArea.text = _songTitleList[_currentSongIndex];
			// update song description
			updateSongDescription();
			isPlaying = true;
			pBar.addEventListener(Event.ENTER_FRAME, updatePosition);
		}
		
		// stop current song
		public function stopSong():void
		{
			if (_soundChannel != null)	_soundChannel.stop();
			isPlaying = false;
			songTime.text = "0:0";
			_currentSongProgress = 0;
			pBar.removeEventListener(Event.ENTER_FRAME, updatePosition);
			Tweener.addTween(pBar,{scaleX:0, time:0.5});
		}
		
		//_____________________________________________ MISC FUNCTION
		
		private function swapButtonDepth():void
		{
			var playDepth:Number = getChildIndex(playButton);
			var pauseDepth:Number = getChildIndex(pauseButton);
			setChildIndex(pauseButton, playDepth);
			setChildIndex(playButton, pauseDepth);
			playButton.alpha = pauseButton.alpha = 1;
		}
		
		private function soundFadeOut():void
		{
			_soundTransform = _soundChannel.soundTransform;
			// Sound fade out
			Tweener.addTween(_soundTransform,{	volume:0,
												time:1,
												onUpdate:function():void
												{
													_soundChannel.soundTransform =_soundTransform;
												}
											});
		}
		
		private function soundFadeIn():void
		{
			_soundTransform = _soundChannel.soundTransform;
			// Sound fade in
			Tweener.addTween(_soundTransform,{	volume:1,
												time:1,
												onUpdate:function():void
												{
													_soundChannel.soundTransform =_soundTransform;
												}
											});				
		}
		
		private function updateSongDescription():void
		{
			// update new text
			descriptionArea.text = _songDescriptionList[_currentSongIndex];
			descriptionArea.width = descriptionArea.textWidth + 10;
		}	
		
		private function updatePosition(e:Event):void
		{
			if (isPlaying)
			{
				// Buffer if needed
				if (_sound.isBuffering)
				{
					_loaded = _sound.bytesLoaded;
					_total = _sound.bytesTotal;
					songTime.visible = false;
					buffering.visible = true;
					buffering.percent.text = Math.floor(_loaded / _total * 100).toString() + " %";
				}
				else
				{
					songTime.visible = true;
					buffering.visible = false;
					// progressbar
					Tweener.addTween(pBar,	{	scaleX:_soundChannel.position / _songLengthList[_currentSongIndex],
												time:0.5
											});
					// time
					var sec = _soundChannel.position * .001;
					songTime.text = Math.floor(sec / 60) + " : " + Math.floor(sec % 60);
					if (maxPosition < _soundChannel.position) maxPosition = _soundChannel.position;
				}
			}
		}
		
		private function seekProgressBar(e:Event):void
		{
			if (isPlaying)
			{
				var temp:Number = e.target.mouseX / e.target.width * _songLengthList[_currentSongIndex];
				if (temp < maxPosition || _sound.bytesLoaded == _sound.bytesTotal)
				{
					_currentSongProgress = temp; 
					_soundChannel.stop();
					_soundChannel = _sound.play(_currentSongProgress);
					_soundChannel.soundTransform = _soundTransform;
				}
			}	
		}
		
		private function dragPlayer(e:Event):void
		{
			this.startDrag(false, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));	
		}
		
		private function unDragPlayer(e:Event):void
		{
			this.stopDrag();
		}
		
			
		
	}
}
