package utils{
	/*
	all required packages and classes
	-----------------------------------------------------------------------------------
	*/
	import flash.display.*;
	import flash.events.*;
	import utils.*;
	public class ball extends MovieClip {
		private var __speedX:Number=0;
		private var __speedY:Number=0;
		public function ball() {
		}
		public function set speedX(_speedX:Number) {
			__speedX=_speedX;
		}
		public function get speedX():Number {
			return __speedX;
		}
		public function set speedY(_speedY:Number) {
			__speedY=_speedY;
		}
		public function get speedY():Number {
			return __speedY;
		}
	}
}