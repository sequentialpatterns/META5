﻿package com.webdevils.utils {	import flash.display.*;	import flash.events.*;	import flash.text.*;	import flash.system.*;		public class MemoryDisplay extends Sprite {		private var _txt:TextField;		private var _fmt:TextFormat;				public function MemoryDisplay( fmt:TextFormat = null ) {			_txt = new TextField();			_txt.selectable = false;			if ( fmt == null ) {				_fmt = new TextFormat();			} else {				_fmt = fmt;			}			addChild( _txt );			addEventListener( Event.ENTER_FRAME, on_enterframe );		}						private function on_enterframe( e:Event ):void {			  var m:String = Number( System.totalMemory / 8 / 1024 / 1024 ).toFixed( 3 ) + 'MB';			  _txt.text = m;			  _txt.setTextFormat( _fmt );		}	}}