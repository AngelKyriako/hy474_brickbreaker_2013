package utils{
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import utils.*;
	public class cherry extends MovieClip {
		private var speed:Number=2;
		private var __paddleClip:MovieClip;
		private var hitdetection:Boolean;
		private var __baseClip:Sprite;
		public function cherry() {
			init();
		}
		public function init() {
			this.addEventListener(Event.ENTER_FRAME,moveMe);
		}
		public function moveMe(e:Event) {
			if (!detection) {
				e.currentTarget.y>(700)?removeMe():e.currentTarget.y+=speed;
				if (e.currentTarget.hitTestObject(paddleClip )) {
					e.currentTarget.gotoAndPlay(2);
					speed=0;
					detection=true;
				}
			}
		}//paddle
		public function set paddleClip(_paddleClip:MovieClip) {
			__paddleClip=_paddleClip;
		}
		public function get paddleClip() {
			return __paddleClip;
		}
		public function set detection(_status:Boolean) {
			hitdetection=_status;
		}
		public function get detection() {
			return hitdetection;
		}
		public function removeMe() {
			this.removeEventListener(Event.ENTER_FRAME,moveMe);
			baseClip.removeChild(DisplayObject(this) );
		}
		//detection test
		public function set baseClip(_baseClip:Sprite) {
			__baseClip=_baseClip;
		}
		public function get baseClip() {
			return __baseClip;
		}

	}
}