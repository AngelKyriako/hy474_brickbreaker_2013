package utils{
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import utils.*;
	public class fakeball extends MovieClip {
		private var __detection:Boolean=false;

		private var __Paddle:MovieClip;
		private var speedX:Number=5;
		private var speedY:Number=5;
		private var direction:Number=-1;
		private var __baseClip:Sprite;
		private var __bricks:Array;
		private var __balldetection:Boolean;
		public function fakeball() {
			init();
		}
		private function init() {
			detection=false;
			this.addEventListener(Event.ENTER_FRAME,moveBall);
		}
		public function removeEvents() {
			this.removeEventListener(Event.ENTER_FRAME,moveBall);
		}
		//enter frame
		private function moveBall(e:Event) {
			e.currentTarget.x-=speedX;
			e.currentTarget.y-=speedY;
			//right side
			if (e.currentTarget.x>(stage.stageWidth-e.currentTarget.width/2)) {
				if (detection) {
					detection=false;
				}
				speedX*=direction;
			}
			//down side
			if (e.currentTarget.y>(stage.stageHeight)) {
				removeMe();
				removeEvents();
			}
			//right side
			if (e.currentTarget.x<(e.currentTarget.width/2)) {
				if (detection) {
					detection=false;
				}
				speedX*=direction;
			}
			//up side
			if (e.currentTarget.y<(e.currentTarget.height/2)) {
				if (detection) {
					detection=false;
				}
				speedY*=direction;
			}
			if (e.currentTarget.hitTestObject(Paddle) && !detection) {
				changeballAngle();
				detection=true;
			}
				brickscollide();
		}
		public function brickscollide():void {
			for (var i in bricks) {
				if (bricks[i]!=null) {
					if (!bricks[i].collide) {
						if (this.hitTestObject(bricks[i]) &&  !balldetection) {
							speedY *= -1;
							balldetection=true;
							detection=false;
						}
					}
				}
			}
		}
		public function set balldetection(_balldetection:Boolean) {
			__balldetection= _balldetection;
		}
		public function get balldetection():Boolean {
			return __balldetection;
		}
		public function set Paddle(_Paddle:MovieClip) {
			__Paddle=_Paddle;
		}
		public function get Paddle():MovieClip {
			return __Paddle;
		}
		//
		public function set detection(_detection:Boolean) {
			__detection=_detection;
		}
		public function get detection() {
			return __detection;
		}//change ball angle and direction when ball collide with the paddle
		private function changeballAngle():void {

			var ballPosition:Number = this.x-Paddle.x;
			var hitPercent:Number = (ballPosition / (Paddle.width - this.width)) - .5;
			speedX = hitPercent * 10;
			//Making the ball bounce back up
			speedY *= -1;
			balldetection=false;
		}
		public function removeMe() {
			baseClip.removeChild(DisplayObject(this) );
		}
		//base
		//detection test
		public function set baseClip(_baseClip:Sprite) {
			__baseClip=_baseClip;
		}
		public function get baseClip() {
			return __baseClip;
		}
		//set bricks
		public function set bricks(_bricks:Array) {
			__bricks=_bricks;
		}
		public function get bricks():Array {
			return __bricks;
		}

	}
}