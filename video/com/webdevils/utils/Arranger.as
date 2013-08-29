﻿package com.webdevils.utils {	import caurina.transitions.Tweener;	    public class Arranger {        public function Arranger() {                   }				public static function make_grid( _array:Array, _cols:uint, _hspace:Number, _vspace:Number, _x:Number = 0, _y:Number = 0 ) {            var count:uint = 0;            for ( var p:String in _array ) {                var _mc = _array[p];                _mc.x = ( count % _cols ) * _hspace;                _mc.y = Math.floor( count / _cols ) * _vspace;                _mc.x += _x;                _mc.y += _y;                count ++;            }        }						public static function make_circle( _array:Array, _radius:Number, _x:Number = 0, _y:Number = 0 ) {			var inc:Number = Math.PI * 2 / _array.length;			var count:uint = 0;			for ( var p:String in _array ) {				var _mc = _array[p];				_mc.x = Math.sin( count * inc ) * _radius;				_mc.y = Math.cos( count * inc ) * _radius;				_mc.x += _x;				_mc.y += _y;				count ++;			}		}						public static function set_a_prop( _obj:Object, _props:Object ):void {			for ( var p:String in _props ) {				_obj[ p ] = _props[ p ];			}		}						public static function set_props( _array:Array, _props:Object ):void {			for ( var p:String in _array ) {				set_a_prop( _array[ p ], _props );			}		}						public static function move_to_grid( _array:Array,                                    _cols:uint,                                    _hspace:Number,                                    _vspace:Number,                                    _x:Number = 0,                                    _y:Number = 0,                                    _time:Number = 1,                                    _transition:String = "easeOutExpo",                                    _delay:Number = 0,                                    _other:Object = null ):void {   			var count:uint = 0;			var _tween:Object = new Object();			_tween.time = _time;			_tween.transition = _transition;			_tween.delay = 0;		   			if ( _other != null ) {				set_a_prop( _tween, _other );			}		   			for ( var p:String in _array ) {				var _mc = _array[p];				var target_x = ( count % _cols ) * _hspace;				var target_y = Math.floor( count / _cols ) * _vspace;				target_x += _x;				target_y += _y;				_tween.x = target_x;				_tween.y = target_y;				_tween.delay = _delay * count;				Tweener.addTween( _mc, _tween );				count ++;			}		}    }}