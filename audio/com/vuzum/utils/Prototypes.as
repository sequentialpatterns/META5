/**
 * Copyright (c) 2009 Vuzum LLC <http://www.vuzum.com/>
 */
package com.vuzum.utils
{
	import caurina.transitions.properties.ColorShortcuts;	
	
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	//
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	//
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	//
	import flash.text.TextField;	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;	
	import flash.text.StyleSheet;
	import flash.text.TextFieldType;
	//	
	import flash.display.*;
	//
	import flash.events.*;
	//
	import flash.system.*;
	import flash.net.LocalConnection;
	
	// OTHER'S IMPORTS
	import caurina.transitions.Tweener;

	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.getTimer;	
	
	public class Prototypes
	{
		// STATIC MEMBERS
		public static var sheet : StyleSheet;
		
		// INTERNAL MEMBERS
		private var tracer : TextField;
		
		
		
		/*
		 * sets the style sheet that will be used in the hole project
		 */
		public static function setStyle(pSheet : StyleSheet = null) : void 
		{
			if (sheet == null) sheet = pSheet;
		}		


		/**
		 * CONSTRUCTOR
		 */
		public function Prototypes()
		{
			
			ColorShortcuts.init();
			
			
			/**************************************************************
			 * 
			 * 					      MOVIECLIPS
			 * 
			 **************************************************************/
			 
			 //for (var item in modulesArray) { trace(item); trace(modulesArray[item].name);}
			 
			/*
			 * flash tracer in browser
			 */
			MovieClip.prototype.ttrace = function(...args) : void
			{
				var str : String = "";
				for(var i : Number = 0; i < args.length; i++) str += args[i] + " ";
				
				if(tracer == null || !this.stage.contains(tracer))
				{
					tracer = TextField(this.stage.addChild(new TextField()));
					
					// properties
					tracer.type = TextFieldType.INPUT;
					tracer.x = 10;
					tracer.y = 10;
					tracer.width = 300; 
					tracer.height = 100; 
					//
					tracer.multiline = true;
					tracer.wordWrap = true;
					tracer.border = true;
					tracer.background = true;
					tracer.selectable = true;		
				}
				
				// put the tracer on the highest depth
				else
				{
					this.stage.setChildIndex(tracer, this.stage.numChildren - 1);
				}
			
				// write the string
				//if(tracer.text == "") tracer.text = str + "\n";
				//else tracer.text += str + "\n";
				if(tracer.text == "") tracer.appendText(str + "\n");
				else tracer.appendText(str + "\n");
			};


			/**
			 * Scales an object to fit inside a square or cropped, based on the value of fitAll
			 * @fitAll - if true, the entire object is scalled to fit the area 
			 *         - if false, an area of the object will remain outside of the area
			 */
			MovieClip.prototype.fitToRect = function(pWidth : Number, pHeight : Number, fitAll : Boolean = true, repositionFlag : Boolean = true) : void
			{
				// first calculate the 2 ratios
				var ratioWidth : Number = pWidth / this.width;
				var ratioHeight : Number = pHeight / this.height;
			  
				if(fitAll)
				{
					//If the height ratio is smaller than the width ratio, we want to use
					//that as are ratio to enlarge in height and width
					if(ratioHeight <= ratioWidth)
					{
						this.height = this.height * ratioHeight;
						this.width = this.width * ratioHeight;
					}
				  	//Otherwise we use the width ratio
				  	else
					{
						this.height = this.height * ratioWidth;
						this.width = this.width * ratioWidth;
					}
				}
				else
				{
					//If the height ratio is smaller than the width ratio, we want to use
					//that as are ratio to enlarge in height and width
					if(ratioHeight > ratioWidth)
					{
						this.height = this.height * ratioHeight;
						this.width = this.width * ratioHeight;
					}
				  	//Otherwise we use the width ratio
				  	else
					{
						this.height = this.height * ratioWidth;
						this.width = this.width * ratioWidth;
					}
				}
				
				
				// force smoothing 
				this.smoothing = true;
			    
				// center the object on the browser window
				if(repositionFlag)
				{
					this.x = Math.round((pWidth - this.width) / 2);
					this.y = Math.round((pHeight - this.height) / 2);
				}
			};


			/**
			 * Rescales an object proportionally on width or height
			 * flag = true - means scale on width
			 */
			MovieClip.prototype.scaleOnProperty = function(nr : Number = 0, flag : Boolean = true) : void
			{
				if(flag) 
				{
					this.width = nr;
					this.scaleY = this.scaleX;
					
					//this.height = Math.round(this.height);
				}
				else
				{
					this.height = nr;
					this.scaleX = this.scaleY;
					
					//this.width = Math.round(this.width);
				}
			};
			
			/*
			 * centrates an object on width or height
			 */
			MovieClip.prototype.centerOn = TextField.prototype.centerOn = function(pWidth : Number = NaN, pHeight : Number = NaN) : void
			{
				if(!isNaN(pWidth)) this.x = Math.round((pWidth - this.width) / 2);
				if(!isNaN(pHeight)) this.y = Math.round((pHeight - this.height) / 2);
			};
			
			
			MovieClip.prototype.centerOnClip = TextField.prototype.centerOnClip = function(pClip : *) : void
            {
                this.centerOn(pClip.width, pClip.height);
                this.x += pClip.x;                this.y += pClip.y;
            };
			
			
			/**
			 * 	ADDS EVENTS TO A MOVIECLIP TO CONTROL IT AS A BUTTON
			 */
			MovieClip.prototype.addEvents = function(scope : Object, flag : Boolean = true) : void 
			{
				// button mode
				this.buttonMode = flag;
				
				// event handlers
				if(scope.overHandler != null) this.addEventListener(MouseEvent.MOUSE_OVER, scope.overHandler);
				if(scope.outHandler != null) this.addEventListener(MouseEvent.MOUSE_OUT, scope.outHandler);				
				if(scope.pressHandler != null) this.addEventListener(MouseEvent.MOUSE_DOWN, scope.pressHandler);
				if(scope.releaseHandler != null) this.addEventListener(MouseEvent.MOUSE_UP, scope.releaseHandler);
			};
			
			/**
			 * 	REMOVE THE EVENTS FROM A MOVIECLIP CONTROLLED AS A BUTTON
			 */
			MovieClip.prototype.removeEvents = function(scope : Object) : void 
			{
				// button mode
				this.buttonMode = false;
				
				// event handlers
				if(scope.overHandler != null) this.removeEventListener(MouseEvent.MOUSE_OVER, scope.overHandler);
				if(scope.outHandler != null) this.removeEventListener(MouseEvent.MOUSE_OUT, scope.outHandler);				
				if(scope.pressHandler != null) this.removeEventListener(MouseEvent.MOUSE_DOWN, scope.pressHandler);
				if(scope.releaseHandler != null) this.removeEventListener(MouseEvent.MOUSE_UP, scope.releaseHandler);
			};
			
			
			/**************************
			* Bandwidth Detector
			
			Downloads a hidden test image from a predefined URL
			and determines client bandwidth based on how
			quickly the image is downloaded. 
			Test image must be ~12k in filesize (smaller filesizes 
			result in inaccurate detections on fast connections). 
			Image is not cached due to random string added to URL.
			(~300kbps cable/DSL, ~20kbps dialup)
			
			*************************/
			
			MovieClip.prototype.detectBandwidth = function(onCompleteFunction : Function = null, contentPath : String = null) : void
			{
				// gloabal vars
				var startTime : Number = getTimer(); //trace("aici:", startTime);
				var endTime : Number;
				var datasize : Number;
				var bandwidth : Number;
				
				// on progress function
				this.onProgressFunction = function(numBytesLoaded : Number, numBytesTotal : Number) : void 
				{
					datasize = numBytesTotal;	
				};
				// on comeplete
				this.onComplete = function(mc : MovieClip) : void
				{
					endTime = getTimer(); //trace("aici: ", endTime);
					var offsetMilliseconds : Number = endTime - startTime;
					var offsetSeconds : Number = offsetMilliseconds / 1000;
					var bits : Number = datasize * 8;
					var kbits : Number = bits / 1024;
					
					// calculate bandwidth
					bandwidth = (kbits / offsetSeconds);
					
					// CALL THE COMPLETE FUNCTION
					onCompleteFunction(Math.round(bandwidth));
				};
				
				// START LOADING
				if(contentPath == null || contentPath == "" || contentPath == "undefined") contentPath = "bandwidth_detection.jpg";
				this.loadContent(contentPath + "?t=" + new Date().getTime(), this.onComplete, null, false, false);
				
				// End bandwidth detector code			 
			};			
			

			/**
			 * Utility function for loading content
			 * @param contentPath			The URL to the content.
			 * @param onCompleteFunction 	The function to be called after the content is loaded
			 * @param mcLoader	    		The loader MovieClip to show while loading
			 * @param showFlag				After the content is loaded is shown or not with tween depending on this param
			 * @param bitmapFlag 			If the content is an image let this param on true so it can look better
			 * @usage loadContent("http://www.vuzum.com/image.jpg", completeFunction, mcLoader, true, true); - last 2 params can miss as they are defined as default, mcLoader can miss too
			 */
			MovieClip.prototype.loadContent = function(contentPath : String, onCompleteFunction : Function = null, mcLoader : * = null, showFlag : Boolean = true, bitmapFlag : Boolean = true) : void
			{
				var pTarget : MovieClip = this as MovieClip;
				
				// RESET POSITION
//				pTarget.x = pTarget.y = 0;
				
				// CLEAR EVERYTHING INSIDE THE HOLDER
				for (var str in pTarget)
				{
//					trace(pTarget[str]); //trace(pTarget[str].name);
//					if(pTarget.contains(pTarget[str])) pTarget.removeChild(pTarget[str]);
				}
				
				// LOAD THE NEW CONTENT IF IS THE CASE
				if(contentPath != "" && contentPath != null) 
				{
					// SHOW THE LOADER movieclip
					if(mcLoader != null) mcLoader.visible = true;
					
					// CREATE THE LOADER
					pTarget.loader = new Loader();
		
		
					// PROGRESS LISTENER
					pTarget.progressEventHandler = function (event : ProgressEvent) : void 
					{ 
//						var nr : Number = Math.round(event.bytesLoaded/event.bytesTotal * 100);
						pTarget.onProgressFunction(event);
					};
					if(pTarget.onProgressFunction != null) pTarget.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, pTarget.progressEventHandler);
					
					
					// add the COMPLETE LISTENER
					pTarget.completeEventHandler = function () : void 
					{ 
						if(pTarget)
						{
							// add the display image to the current movieclip
							if(pTarget.loader != null && pTarget.loader.content != null) 
							{
								// first remove the old bitamp if it was
								if(pTarget.flashmo_bm != null) pTarget.removeChild(pTarget.flashmo_bm);
								
								// create a bitmap if is the case
								if(bitmapFlag)
								{
									pTarget.flashmo_bm = Bitmap(pTarget.loader.content);
									pTarget.flashmo_bm.smoothing = true;
								}
								else pTarget.flashmo_bm = pTarget.loader.content;
								
								// add the new content
								pTarget.content = pTarget.addChild(pTarget.flashmo_bm);
							}
							
							// hide the loader
							if(mcLoader != null) mcLoader.visible = false; 
								
							// show the new loaded content holder with tween if is the case
							if(showFlag) 
							{
								pTarget.alpha = 0;
								pTarget.showObject();
							}
							
							// call the complete listener of the target
							if(onCompleteFunction != null)
							{ 
								if(onCompleteFunction.length) onCompleteFunction(pTarget);
								else onCompleteFunction();
							}
						}
					};
					pTarget.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, pTarget.completeEventHandler);
					
					
					// add the STOP LOADING FUNCTION so the user can stop the loading
					pTarget.stopLoading = function() : void
					{
						pTarget.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, pTarget.completeEventHandler);
						
						if(pTarget.loader)
						{
							try {pTarget.loader.close();}catch(e:*) {}
							pTarget.loader.unload();
							
							pTarget.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, pTarget.onCompleteFunction);
							pTarget.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, pTarget.progressEventHandler);
						}
					};
					
									
					// ERROR LISTENER
					pTarget.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function() : void 
					{
						trace("The content doesn't exist!");
						// call the complete listener of the target
						if(pTarget.onIOErrorFunction != null) pTarget.onIOErrorFunction();						
					});
					
					
					// LOAD AND SHOW THE NEW CONTENT
					pTarget.loader.load(new URLRequest(contentPath), new LoaderContext(true));
				}
			};
			
			/*
			 * SHOWS / HIDES a movieclip with tween
			 */
			MovieClip.prototype.showObject = function(flag : Boolean = true, completeFunction : Function = null, time : Number=NaN) : void
			{
				var showObjectTime : Number = (isNaN(time) ? 0.5 : time);
				var goToAlpha : Number = ((flag) ? 1 : 0);
				
				if(flag) this.visible = flag;
				Tweener.addTween(this, {alpha : goToAlpha, time : showObjectTime, transition : "easeOutExpo", onComplete : function() : void 
				{
					this.visible = flag;
					
					if(completeFunction != null) completeFunction();
				}});
			};
			




			/******************** COLORS *************************/
			MovieClip.prototype.setColor = function(pColor : Number = NaN) : void 
			{
				if(!isNaN(pColor)) Tweener.addTween(this, {_color : pColor, time : 0});
			};
			
			MovieClip.prototype.removeColor = function() : void 
			{
				Tweener.addTween(this, {_color : null, time : 0, transition : "easeOutExpo"}); 
			};
						
			/**
			 * Changes the brightness of a MovieClip
			 *@param level the new level of Brightness
			 *@return void 
			 */
			MovieClip.prototype.setBrightness = function(level : Number) : void
			{
				var myElements_array : Array = [1, 0, 0, 0, level,
                                        0, 1, 0, 0, level,
                                        0, 0, 1, 0, level,
                                        0, 0, 0, 1, 0];
				var myColorMatrix_filter : ColorMatrixFilter = new ColorMatrixFilter(myElements_array);
				this.filters = [myColorMatrix_filter];
			};
            

			/**
			 * Converts a MovieClip colors to Garyscale
			 */
			MovieClip.prototype.setToGrayscale = function() : void
			{
		
				this.cacheAsBitmap = true;
		
				var matrix : Array = new Array();
		
				matrix = matrix.concat([0.308600038290024, 0.609399974346161, 0.0820000022649765, 0, 0]);
		
				// red

				matrix = matrix.concat([0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0]);
		
				//green

				matrix = matrix.concat([0.308600008487701, 0.609399974346161, 0.0820000246167183, 0, 0]);
		
				// blue

				matrix = matrix.concat([0, 0, 0, 1, 0]);
		
				// alpha

				var filter : BitmapFilter = new ColorMatrixFilter(matrix);
		
				this.filters = new Array(filter);
			};
		
			/**
			 * Removes Grayscale form a MovieClip
			 */
			MovieClip.prototype.removeGrayscale = function() : void
			{
				this.filters = new Array();
			};	        

	        
			/*
			 * DOT RUN
			 */
			MovieClip.prototype.dotrun = function(mydottext : String, char : String) : void
			{
				this.dots = 0;
				this.dotdir = 0;
				//	            if (char == undefined)
				//	            {
				//	                char = ".";
				//	            }
				this.maxdot = 4;
				this.onEnterFrame = function() : void
				{
					this.dots += this.dotdir;
					if (this.dots >= this.maxdot)
					{
						this.dotdir = -1;
					}
					else if (this.dots < 1)
					{
						this.dotdir = 1;
					}
					this.tempdots = "";
					for (var dc : Number = 0;dc < this.dots; dc++)
					{
						this.tempdots += char;
					}
					this.txt.htmlText = mydottext + this.tempdots;
				};
			};
			
			
			/*
			 * A NICE TYPEWRITER TEXT EFFECT
			 */
			MovieClip.prototype.typewriter = function(newtext : String, oldtext : String, lspeed : Number, blinkdelay : Number, f : Function, v : Object) : void 
			{
				this.charToUse = " ";
				//
				if (oldtext == null)
				{
					oldtext = "";
				}
				this.temptext = oldtext;
				this.counter = 0;
				this.i = oldtext.length;
				//	            if (lspeed == null)
				//	            {
				//	                lspeed = 1;
				//	            }
				//	            if (blinkdelay == null)
				//	            {
				//	                blinkdelay = 31;
				//	            }

				this.onEnterFrame = function() : void 
				{
					for (var mylspeed : Number = 0;mylspeed < lspeed; mylspeed++)
					{
						this.temptext = this.temptext + newtext.charAt(this.i);
						if (newtext.charAt(this.i) == "<")
						{
							var htmlend : Number = newtext.indexOf(">", this.i);
							var htmladd : Number = htmlend - this.i;
							this.i = this.i + htmladd;
							this.temptext = newtext.substr(0, this.i);
							continue;
						}
						this.i++;
					}
					this.txt.htmlText = this.temptext + this.charToUse;
					if (this.i >= newtext.length)
					{
						this.mybool = 1;
						this.onEnterFrame = function():void 
						{
							this.counter++;
							this.mybool = !this.mybool;
							if (this.mybool == true)
							{
								this.txt.htmlText = this.temptext + this.charToUse;
							}
							else
							{
								this.txt.htmlText = this.temptext;
							}
							if (this.counter >= blinkdelay)
							{
								this.txt.htmlText = this.temptext;
								this.counter = 0;
								this.blinkremove();
								delete this["onEnterFrame"];
								f(v);
							}
						};
					}
				};
			};
			
			
			/*
			 * REMOVE THE MOVIECLIP USED FOR THE TYPEWRITER EFFECT
			 */
			MovieClip.prototype.blinkremove = function():void 
			{
				this.onEnterFrame = function():void 
				{
					this._alpha = this._alpha - 10;
					this._visible = !this._visible;
					if (this._alpha <= 0)
					{
						this.removeMovieClip();
					}
				};
			};
	        
        



			/**************************************************************
			 * 
			 * 					      TEXT FIELD
			 * 
			 **************************************************************/
			// inits and writes a textfield
			TextField.prototype.initText = function(str : String = "", mouseEnabledFlag : Boolean = false, autoSizeFlag : Boolean = true) : void 
			{
				// AUTO SIZE
				this.autoSize = (autoSizeFlag ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE);
				
				// SCROLLABLE
				//this.selectable = false;
				
				// EMBED FONT
				this.embedFonts = true;
				
				// MOUSE ENABLED
	            this.mouseEnabled = mouseEnabledFlag;
	            
	            // TEXT
	            this.htmlText = str;
			};
			
			// inits and writes a textfield with the CSS read from a class
			TextField.prototype.initCSSText = function(str : String = "", mouseEnabledFlag : Boolean = true) : void 
			{
				// AUTO SIZE
				this.autoSize = TextFieldAutoSize.LEFT;
				
				// SCROLLABLE
				//this.selectable = false;
				
				// MOUSE ENABLED
	            this.mouseEnabled = mouseEnabledFlag;
	            
				// CSS
				if(sheet) this.styleSheet = sheet;
	            
	            // TEXT
	            this.htmlText = str;
			};
			
					
			// changes the color of a textfield
			TextField.prototype.setColor = function(pColor : Number) : void 
			{
				var fmt : TextFormat = new TextFormat();
				//fmt.font = "Helvetica";
				fmt.color = pColor;
				//fmt.bold = true;
				//fmt.size = 20;
				this.setTextFormat(fmt);
			};	
			
			// changes the size of a textfield
			TextField.prototype.setSize = function(nr : Number) : void 
			{
				var fmt : TextFormat = new TextFormat();
				fmt.size = nr;
				this.setTextFormat(fmt);
			};
			
			// checks if a textfield is not empty, is number or email
			TextField.prototype.isValid = function(scope : *, type : String = "") : Boolean 
			{
				var txfd : TextField = this as TextField;
				 
				// check if is empty
				if (txfd.text.toString() == "" || txfd.text.toString() == null) 
				{
					scope.stage.focus = this;
					
					//this.mcError.typewriter(errorText, "", 5, 10);
					scope.mcError.txt.text = scope.emptyFieldMessage;
					
					return false;
				}
				
				// check if is number
				if(type == "number" && isNaN(Number(txfd.text)))
				{
					scope.stage.focus = txfd;
					
					//this.mcError.typewriter(errorText, "", 5, 10);
					scope.mcError.txt.text = scope.NaNFieldMessage;
					
					return false;				
				}
				
				// check if is email
				if(type == "email" && !txfd.text.toString()["isEmail"]())
				{
					scope.stage.focus = txfd;
					
					//this.mcError.typewriter(errorText, "", 5, 10);
					scope.mcError.txt.text = scope.invalidMailFieldMessage;
					
					return false;				
				}			
				
				// if is correct
				scope.mcError.txt.text = "";
				return true;
			};
			

	        
			/**************************************************************
			 * 
			 * 					      STRING
			 * 
			 **************************************************************/
			 /*
			  * takes out white spaces from a string
			  */	        
			  
			String.prototype.trim = function () : String
			{
				var s : String = String(this);
				while (true)
				{
					if (s.charAt((s.length - 1)) == " " || s.charAt((s.length - 1)) == "\n" || s.charAt((s.length - 1)) == "\r") 
					{
						s = s.substr(0, (s.length - 1));
					} else 
					{
						break;
					}
				}
				var i : Number = 0;
				while (true) 
				{
					if (s.charAt(i) == " " || s.charAt(i) == "\n" || s.charAt(i) == "\r") 
					{
						s = s.substr((i + 1), (s.length - 1));
					} else 
					{
						break;
					}
					i++;
				}
				return s;
			};
	
			
			// replaces a substring in a string
			String.prototype.replaceSubString = function (replaceFrom : String, replaceTo : String, caseSensitive : Boolean) : String 
			{
				var start : Array = this.split(replaceFrom);
				var tmp : String = start.join(replaceTo);
				if (!caseSensitive) 
				{
					start = tmp.split(replaceFrom.toLowerCase());
					tmp = start.join(replaceTo);
					start = tmp.split(replaceFrom.toUpperCase());
					tmp = start.join(replaceTo);
				}
				return tmp;
			};
			
			//  CHECKS IF A STRING IS EMAIL
			String.prototype.isEmail = function() : Boolean
			{
				// email address has to have at least 5 chars
				if (this.length < 6)
				{
					return false;
				}
				
				// not allowed charcters
				var iChars : String = "*|,\":<>[]{}`';()&$#%+";
				var eLength : Number = this.length;
				for (var i : Number = 0;i < eLength; i++)
				{
					if (iChars.indexOf(this.charAt(i)) != -1)
					{
						//trace("Invalid Email Address : Illegal Character in Email Address : -->"+this.charAt(i)+"<--.");
						return false;
					}
				}
				
				// position of @
				var atIndex : Number = this.lastIndexOf("@");
				if (atIndex < 1 || (atIndex == eLength - 1))
				{
					//trace("Invalid Email Address : Email Address must contain @ as at least the second chararcter.");
					return false;
				}
				// 2 of @ are not allowed
				if(this.indexOf("@") != atIndex) return false;
	            
				// position of last .
				var dotIndex : Number = this.lastIndexOf(".");
				if (dotIndex < 4 || (dotIndex == eLength - 1) || (dotIndex >= eLength - 2))
				{
					//trace("Invalid Email Address : Email Address must contain at least one . (period) in a valid position");
					return false;
				}
	            
				// position of last . after @
				if (1 >= dotIndex - atIndex)
				{
					//trace("Invalid Email Address : Email Address must be in the form of name@domain.domaintype");
					return false;
				}
	            
	            
				// not 2 of . or @ consequently
				for (i = 0;i < eLength; i++)
				{
					if ((this.charAt(i) == "." || this.charAt(i) == "@") && this.charAt(i) == this.charAt(i - 1))
					{
						//trace("Invalid Email Address : Cannot contain two \".\" or \"@\" in a row : -->" + this.charAt(i) + "<--.");
						return false;
					}
				}
	            
				return true;
			};
			
			
//		    private function validateEmail(email : String) : Boolean 
//		    {		
//		        var fstLett : String = email.substring(0, 1);
//		        var lastLett : String = email.substring(email.length, -1);
//		        var minLettAfterLastPoint : Number = 2;
//		        var maxLettAfterLastPoint : Number = 4;
//		        var minLettBeforeAt : Number = 1;
//		        var maxLettBeforeAt : Number = 20;
//		        var minLettAfterAt : Number = maxLettAfterLastPoint;
//		        var firstAt : Number = email.indexOf("@", 0);
//		        var lastAt : Number = email.lastIndexOf("@", email.length);
//		        var strBeforeAt : String = email.substring(0, firstAt);
//		        var lettBeforeAt : String = email.charAt(firstAt - 1);
//		        var lettAfterAt : String = email.charAt(firstAt + 1);
//		        var firstScore : Number = email.indexOf("-", 0);
//		        var lettBeforeScore : String = email.charAt(firstScore - 1);
//		        var lettAfterScore : String = email.charAt(firstScore + 1);
//		        var firstUnderscore : Number = email.indexOf("_", 0);
//		        var lettBeforeUnderscore : String = email.charAt(firstUnderscore - 1);
//		        var lettAfterUnderscore : String = email.charAt(firstUnderscore + 1);
//		        var firstPoint : Number = email.indexOf(".", 0);
//		        var lastPoint : Number = email.lastIndexOf(".", email.length);
//		        var lettAfterLastPoint : Number = email.length - lastPoint - 1;
//		        var morePoints : Number = email.indexOf("..", 0);
//		        var moreScore : Number = email.indexOf("--", 0);
//		        var extensionScore : Number = email.indexOf("-", lastPoint);
//		        var extensionUnderscore : Number = email.indexOf("_", lastPoint);
//		        
//		        if (email == "" ||
//		        	!isNaN(Number(fstLett)) || 
//		        	!isNaN(Number(lastLett)) || 
//		        	fstLett == "." || fstLett == "-" || fstLett == "_" || 
//		        	lastLett == "." || lastLett == "-" || lastLett == "_" || 
//		        	firstAt == -1 || firstAt >= (email.length - minLettAfterAt) || firstAt == 0 || firstAt !== lastAt || 
//		        	firstPoint == 0 || 
//		        	lastPoint == -1 || 
//		        	lettAfterLastPoint < minLettAfterLastPoint || lettAfterLastPoint > maxLettAfterLastPoint || 
//		        	lettBeforeAt == "." || lettBeforeAt == "_" || lettBeforeAt == "-" || lettBeforeAt == " " || 
//		        	lettAfterAt == "." || lettAfterAt == "_" || lettAfterAt == "-" || lettAfterAt == " " || 
//		        	lettBeforeScore == "." || lettBeforeScore == "_" || lettBeforeScore == "@" || 
//		        	lettAfterScore == "." || lettAfterScore == "_" || lettAfterScore == "@" || 
//		        	lettBeforeUnderscore == "." || lettBeforeUnderscore == "-" || lettBeforeUnderscore == "@" || 
//		        	lettAfterUnderscore == "." || lettAfterUnderscore == "-" || lettAfterUnderscore == "@" || 
//		        	morePoints !== -1 || 
//		        	moreScore !== -1 || 
//		        	extensionScore !== -1 || 
//		        	extensionUnderscore !== -1 || 
//		        	strBeforeAt.length < minLettBeforeAt || strBeforeAt.length > maxLettBeforeAt) 
//		        {
//		            return false;
//		        } 
//		        else 
//		        {
//		            return true;
//		        }
//		    }			
			
			
			
			
			/***************************************************
			 * 
			 * 					DATE
			 * 
			 ***************************************************/			
			
			Date.prototype.toSlashFormat = function() : String 
			{
				return (this.getMonth()+1 + "/" + this.getDate() + "/" + this.getFullYear());
			};
			
			
		}// FROM CONSTRUCTOR
		
		
		/*
		 * determines the number of days in a month
		 */
		public static function numberOfDays(monthNo : Number=1, yearNo : Number = NaN) : Number
		{
			var noDays : Number = 0;
			
			switch(monthNo)
			{
				// months with 31 days
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					noDays = 31;
					break;
				
				// months with 30 days	
				case 4:
				case 6:
				case 9:
				case 11:
					noDays = 30;
					break;					
				
				// february	month
				case 2:
					var tempYearNo : Number = ((isNaN(yearNo)) ? new Date().getFullYear() : yearNo);
					noDays = ((tempYearNo % 4) ? 28 : 29);
					break;					
			}
			return noDays;
		}
		
		/*
		 * determines the number of days between 2 dates
		 */
		public static function getDaysBetweenDates(date1:Date, date2:Date) : Number
		{
			var one_day:Number = 1000 * 60 * 60 * 24;
			var date1_ms:Number = date1.getTime();
			var date2_ms:Number = date2.getTime();		    
			var difference_ms:Number = Math.abs(date1_ms - date2_ms);	    
			return Math.round(difference_ms/one_day);
		}		
		
	    
		/***************************************************
		 * 
		 * 					ARRAY FUNCTIONS
		 * 
		 ***************************************************/		 
	    
	    
		/*
		 * insterts an element in an array at the @param position 
		 */
        public static function insert(a : Array, index : uint, value : *) : Array
        {
           if(!(index >= 0)) return a;
           var original : Array = a.slice();
           var temp : Array = original.splice(index);
           original[index] = value;
           original = original.concat(temp);
           return original;
        }
		
		/*
		 * takes out an element from an array at the @param position 
		 */
        public static function pull(a : Array, value : *) : Array
        {
        	if(a.length<1) return a;
        	
          	var newArray : Array = new Array();
           
           	for(var i : Number = 0; i < a.length; i++)
			{
				if(a[i] != value) newArray.push(a[i]);
			}
            
            a = newArray;
			return newArray;
        }
        
		/*
		 * randomizes an array
		 */		
        public static function randomize(a : Array) : Array
        {
            var i : Number = a.length;
            if (i == 0) return a;
            
            while (--i) 
            {
                var j : Number = Math.floor(Math.random()*(i+1));
                var tmp1 : * = a[i];
                var tmp2 : * = a[j];
                a[i] = tmp2;
                a[j] = tmp1;
            }
            
            return a;
        }
        
        public static function randoMix(rdm : Number = 10) : Array
		{
			var a : Array = new Array;
			
			for (var i : Number = 0; i < rdm; i++)
			{
				a[i] = i;
			}
			
			a = randomize(a);
			
			return a;
		}
        
        /*
         * removes the dupplicates from an array
         */
		public static function removeDuplicates(array : Array) : Array
        {
            var tempArray : Array = new Array();
            
            for (var i : Number = 0; i < array.length; i++)
                if(tempArray.indexOf(array[i]) < 0) tempArray.push(array[i]);    
            
            return tempArray;
        }        
                
        /*
         * traces an array
         */
        public static function traceArray(a : Array) : String
        {
        	var str : String = "";
        	
           	for(var i : Number = 0; i < a.length; i++)
			{
				str += a[i].name + " ";
			}
			
			trace("ARRAY:", str);
			return str;
        }        
        
		
		/***************************************************
		 * 
		 * 					SWF CHECK FUNCTIONS
		 * 
		 ***************************************************/		
		
		/**
	     * checks the expiration date and starts the appplication
	     * call : if(Prototypes.isExpired(15, 8, 2009))
	     */
	    public static function isExpired(expirationDay : Number, expirationMonth : Number, expirationYear : Number) : Boolean
	    {
			// current date  
			var currentDate : Date = new Date();
			var expirationDate : Date = new Date(expirationYear, expirationMonth-1, expirationDay);
			
			if(currentDate >= expirationDate) return true; 
	
			return false;
	    }         
	
	
	     /**
	       * Tests if the current SWF file is stolen
	       * @return TRUE if it is a stolen swf
	       * @param isPreviewFile - this var will be set to true when compiling preview/protected files
	       */
	    public static function isStolen():Boolean 
		{
			var _domain : String = (new LocalConnection()).domain;
	        var _allowedDomainList : Array = new Array();
	
	        //------- add here all strings that would have to be found in allowed domain names --------o
	        _allowedDomainList.push("flabell");
	        _allowedDomainList.push("vuzum");
	        _allowedDomainList.push("localhost");    //add localhost and 127.0.0.1 to be able to run locally
	        _allowedDomainList.push("127.0.0.1");
	        //--------------------------------------------o
	
			for(var i : Number = 0; i < _allowedDomainList.length; i++)
				if (_domain.toLowerCase().indexOf(_allowedDomainList[i].toString().toLowerCase()) > -1) return false;
			return true;
		}        
        
		/***************************************************
		 * 
		 * 					AUX FUNCTIONS
		 * 
		 ***************************************************/		
        /**
         * determines a random number between the params values
         */
		public static function randomBetween(min : Number, max : Number) : Number 
        {
            var randomNum : Number = Math.round(Math.random() * (max - min) + min);
            return randomNum;
        } 
        		 
	    /**
	     * sends some vars to an url and executes a handler on response
	     * @param url 				The path to the php script
	     * @param varsArray 		An array of pairs of vars
	     * @param completeHandler 	The function to be called after the response from the php script has been received
	     * usage: Prototypes.sendAndload(loadScript, ["videoId", 3, "startSec", 3, "endSec", 10], completeHandler);
	     */
		//public static function sendAndload(url : String, varsObject : Object, completeHandler : Function) : void
		public static function sendAndload(url : String, varsArray : Array = null, completeHandler : Function = null, ioErrorHandler : Function = null, progressHandler : Function = null) : void
		{		 
			// send vote to the php script
			var scriptRequest : URLRequest = new URLRequest(url);
  			var scriptLoader : URLLoader = new URLLoader();
  			var scriptVars : URLVariables = new URLVariables(); //URLVariables(varsObject); //
  			
			// prepare event listners
            scriptLoader.addEventListener(Event.COMPLETE, function(event : Event) : void {if(completeHandler != null) completeHandler(event);});
            scriptLoader.addEventListener(IOErrorEvent.IO_ERROR, function(event : IOErrorEvent) : void {if(ioErrorHandler  != null) ioErrorHandler(event);});
            scriptLoader.addEventListener(ProgressEvent.PROGRESS, function(event : ProgressEvent) : void {if(progressHandler != null) progressHandler(event);});
            
			// write the load vars
//			for each(var property in varsObject)
//            {
//				trace(property);
//				scriptVars[property] = varsObject[property];
//				//trace(varsObject[property]);            	
//            }			
            
			for(var i : Number = 0; i < varsArray.length; i+=2)
            {
				scriptVars[varsArray[i]] = varsArray[i+1];
				//trace(varsArray[i], varsArray[i+1]);            	
            }			            
			
			// setup the loader
			scriptLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			scriptRequest.method = URLRequestMethod.POST;
			scriptRequest.data = scriptVars;
			
			// make the script request
			scriptLoader.load(scriptRequest);
		}		 
		
		/*
		 * LOADS AN XML FILE AND CALLS THE COMPLETE FUNCTION WITH THE XML OBJECT AS PARAM
		 * call: loadXML(file.xml, completeFunction, mcLoader);
		 */
		public static function loadXML(xmlPath : String = null, completeFunction : Function = null, mcLoader : * = null, errorFunction : Function = null, progressFunction : Function = null) : void
		{
			if(mcLoader != null) 
			{
				mcLoader.visible = true;
			}
			
			
			// LOAD THE XML AND AFTER call the complete function
			var xmlLoader : URLLoader; //trace(xmlPath);
			if(xmlPath != "" && xmlPath != null) 
			{
				xmlLoader = new URLLoader(new URLRequest(xmlPath));
				xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, function() : void 
				{
					trace("The file does not exist!");
					if(errorFunction != null) errorFunction();
				});
				xmlLoader.addEventListener(ProgressEvent.PROGRESS, function(event : ProgressEvent) : void {if(progressFunction != null) progressFunction(event.bytesLoaded, event.bytesTotal);});
				xmlLoader.addEventListener(Event.COMPLETE, function(e : Event) : void
				{				
					// READ THE ROOT
					var xmlObject : XML = new XML(e.target.data);
					xmlObject.ignoreWhitespace = true;
					
					if(mcLoader != null) mcLoader.visible = false;
					
					// CALL THE COMPLETE FUNCTION
					if(completeFunction != null) completeFunction(xmlObject);
				});
			}			
			else
			{
				trace("The file does not exist!");
				if(errorFunction != null) errorFunction();
			}
		} 

		public function getScope() : Prototypes
		{
			return this;
		}
		
		// read number values from XML
		public static function readNumberVar(pValue : *, pDefaultValue : Number = NaN) : Number
		{
			if(pValue != "" && pValue != null && !isNaN(pValue)) return Number(pValue);
			return pDefaultValue;			
		}
		
		// read boolean values from XML
		public static function readBooleanVar(pValue : *, pDefaultValue : Boolean = false) : Boolean
		{
			if(pValue == "true") return true;
			return pDefaultValue;			
		}
		
		// read path to files
		public static function readPathTo(pValue : *, pDefaultValue : String = null) : String
		{
			if(pValue != null) return pValue;
			return pDefaultValue;			
		}
		// read string values from XML		public static function readStringVar(pValue : *, pDefaultValue : String = "") : String
		{
			if(pValue != "" && pValue != null) return pValue;
			return pDefaultValue;			
		}
		// read a path to an asset from XML
		public static function readAssetPath(pValue : *, pPathToFiles : String = "") : String
		{		
			return (pValue.indexOf("://") == -1 ? pPathToFiles : "") + pValue;
		}
		
		/*
         * function useful for arranging elements in a grid, based on columns or lines 
         */ 
		public static function  makeGrid() : void
		{
//			for (var i = 1; i <= maxNr; i++) 
//			{
//				var mc:MovieClip = mc0.duplicateMovieClip("mc"+i, i);
//				mc.nr = i;
//				
//				mc._x = mc0.x + (mc0.width + distanceX)*((i-1) % nrColumns);
//				mc._y = mc0.y + (mc0.height + distanceY)*(int((i-1) / nrColumns));
//				
//				/*
//				mc._x = mc0.x + (mc0.width + distanceX)*(int((i - 1) / nrLines));
//				mc._y = mc0.y + (mc0.height + distanceY)*((i - 1) % nrLines);
//				*/
//			}
		}


	} // FROM CLASS
}// FROM PACKAGE