﻿package com.rimv.net{    public class PlayListSearch    {		import flash.net.URLLoader ;		import flash.net.URLRequest ;		import flash.xml.* ;		import flash.events.* ;		import flash.errors.* ;				//private var xmlGallery:String = strServerName + "xmlData/ANS_Featured.xml" ;		public var search_term:String ;		private var search_field:String ;		public var search_playListXml:XML;				public var search_playListXmlList:XMLList;				public var results_playListXml:XML;		public var results_playListXmlList:XMLList;				public var results_arrPlayListIndex:Array;								public function PlayListSearch(){					}										        public function searchPlayList(_searchTerm:String, _playListXml:XML):XML{			//trace(_searchTerm) ;			search_term = _searchTerm ;			search_field = "promo";			search_playListXml = _playListXml ;					//***GET WALL GALLERY THAT IS ACTIVE			//userXmlList = galleryXML..gallery.(@galleryId == galleryId).media ;			search_playListXmlList = search_playListXml..item ;			//trace(search_playListXmlList.length()) ;			results_arrPlayListIndex = new Array();			return buildSearchResults() ;            //trace("here") ;        }						private function buildSearchResults():XML{			var _searchFieldValue:String ;			//var _searchField:String = "description";			var _indexHolder:Array = new Array();			//var _searchString:String = "Tribe" ;			//var _searchString:String = search_term ;			//trace(_searchString) 			var _reg_search:RegExp = new RegExp(search_term,"i") ;			var _strResultXml:String = "<manual>" ;			var _countResult:Number = 0 ;			for (var i:int = 0; i <= search_playListXmlList.length()  - 1 ; i++) {				//_colCommentList.push(search_playListXmlList[i]..description) ;				switch (search_field){										case "title":						_searchFieldValue = search_playListXmlList[i].title ;						break;					case "recording":						_searchFieldValue = search_playListXmlList[i].recording ;						break;					default:											//DESCTPTIONS SEARCH						_searchFieldValue = search_playListXmlList[i].promo ;						//trace(this["search_playListXmlList[0].description"])						break;				}								if(_reg_search.test(_searchFieldValue)){					//trace(_searchFieldValue + ":" + _reg_search.test(_searchFieldValue).toString()) ;					_strResultXml += renderPlayListNode(search_playListXmlList[i]) ;										results_arrPlayListIndex[_countResult] = i ;					_countResult += 1 ;				}			} 						_strResultXml += "</manual>" ;			//trace(_strResultXml) ;			results_playListXml = new XML(_strResultXml) ;			return results_playListXml ;			//strTmp = _strResultXml ;					}						private function renderPlayListNode(_playList:XML):String{			//***RE-BUILD PLATLIST ITEM NODE***						var _trackList:XMLList = _playList..track ;						var strXml:String = "<item>";				//***RE-CREATE ITEM***				strXml += "<title>" + _playList.title + "</title>";				strXml += "<asset>" + _playList.asset + "</asset>";				strXml += "<promo>" + _playList.promo + "</promo>";				strXml += "<recording>" + _playList.recording + "</recording>";				strXml += "<caption>" + _playList.caption + "</caption>";				//strXml += "<description>" + _playList.description + "</description>";				strXml +=  "</item>" ;							return strXml ;							}		/*		public function set userIdSet(_userId:String){			_currentUserId = _userId		}				public function get userIdGet():String{			return _currentUserId		}*/				    }}