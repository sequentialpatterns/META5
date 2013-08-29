﻿package com.rimv.net {	import flash.events.*;	import flash.display.*;		public class AudioPlayerView extends EventDispatcher {		private var _model:AudioPlayer;		private var _play_mc:MovieClip;		private var _pause_mc:MovieClip;		private var _rwd_mc:MovieClip;		private var _fwd_mc:MovieClip;				public function AudioPlayerView( model:AudioPlayer, 										playButton:MovieClip, 										pauseButton:MovieClip, 										rewindButton:MovieClip,										fwdButton:MovieClip ) {									_model = model;			_play_mc = playButton;			_pause_mc = pauseButton;			_rwd_mc = rewindButton;			_fwd_mc = fwdButton;						_model.addEventListener( Event.CHANGE, on_change );						setup_buttons();			on_change();		}				//i think we need to add event listeners for ff and rw...		private function setup_buttons():void {			_play_mc.addEventListener( MouseEvent.CLICK, click_play );			_pause_mc.addEventListener( MouseEvent.CLICK, click_pause );			_play_mc.stop();			_play_mc.buttonMode = true;			_play_mc.mouseChildren = false;			_pause_mc.stop();			_pause_mc.buttonMode = true;			_pause_mc.mouseChildren = false;						_fwd_mc.stop();			_fwd_mc.buttonMode = true;			_fwd_mc.mouseChildren = false;						_rwd_mc.stop();			_rwd_mc.buttonMode = true;			_rwd_mc.mouseChildren = false;		}				//will need to add functions for ff and rw below...				private function click_play( e:MouseEvent ):void {			_model.play();		}				private function click_pause( e:MouseEvent ):void {			_model.pause();		}				private function on_change( e:Event = null ):void {			if ( _model.url != "" ) {				if ( _model.is_playing ) {					disable_button( _play_mc );					enable_button( _pause_mc );				} else {					disable_button( _pause_mc );					enable_button( _play_mc );				}			} else {				disable_button( _play_mc );				disable_button( _pause_mc );				//disable_button( _fwd_mc );//added 05.05.2009				//disable_button( _rwd_mc );//added 05.05.2009			}		}				private function disable_button( which_button ):void {			which_button.buttonMode = false;			which_button.gotoAndStop( "disabled" );		}				private function enable_button( which_button ):void {			which_button.buttonMode = true;			which_button.gotoAndStop( "_up" );		}	}}