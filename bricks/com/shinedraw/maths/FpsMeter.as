/****************************************************************************

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

-- Copyright 2009 Terence Tsang
-- admin@shinedraw.com
-- http://www.shinedraw.com
-- Your Flash vs Silverlight Repositry

****************************************************************************/


package com.shinedraw.maths {
	import flash.text.TextField;	
	import flash.events.Event;	
	import flash.display.Sprite;
	
	/*
	*	A FPS Meter Demonstration in Actionscript 3
	*   from shinedraw.com
	*/
	public class FpsMeter extends Sprite {
		private static var SAMPLE_SIZE:int = 20;		// Calculation Sample Size
		private static var PREFIX:String = "FPS: ";		// Display Prefixe
		private static var DIGITS:int = 6;				// Display Digits
		private static var SPRINGNESS:Number = 0.2; 	// Springness
		
		private var _fps:Number = 0;					// FPS
		private var _displayFps:Number = 0;				// Display FPS
		private var _date : Date;						// Temp Date
		private var _counter:int = 0;					// Counter
		private var _fpsTxt : TextField;				// TextField

		public function FpsMeter() {
			// get the TextField
			_fpsTxt = getChildByName("fpsTxt") as TextField;
			// set the date
			_date = new Date();
			addEventListener(Event.ENTER_FRAME, on_enter_frame);
		}
		
		public function on_enter_frame(e : Event):void{
			// calculate the FPS on SAMPLE_SIZE instance
			if(_counter++ == SAMPLE_SIZE){
				var now:Date = new Date();
				_fps = _counter/ ((now.time - _date.time) / 1000 ) ;
				_counter = 0;
				_date = now;
			}

			// Display the FPS
			_displayFps += (_fps - _displayFps) * SPRINGNESS;
			_fpsTxt.text = PREFIX + _displayFps.toString().substr(0, DIGITS);
							
		}
		
	
		/////////////////////////////////////////////////////        
		// Handlers 
		/////////////////////////////////////////////////////	
			
		/////////////////////////////////////////////////////        
		// Private Methods 
		/////////////////////////////////////////////////////	
		
		/////////////////////////////////////////////////////        
		// Public Methods 
		/////////////////////////////////////////////////////	
		
		/////////////////////////////////////////////////////        
		// Properties
		/////////////////////////////////////////////////////			
	}
}
