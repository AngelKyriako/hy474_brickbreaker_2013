package utils{
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import utils.*;
	public class blue extends MovieClip {
		private var __parent:Sprite;
		private var hitdetection=false;
		private var _banner:MovieClip;
		private var __hitObject:MovieClip;
		private var __baseClip:Sprite;
		private var point:MovieClip;
		private var Fakeball:MovieClip;
		private var __paddleClip:MovieClip;
		private var __bricks:Array;
		private var __collide:Boolean;
				private var __scoreboard:MovieClip;
		public function blue() {
			init();
		}
		private function init():void {
			collide=false;
			addEventListener(Event.ENTER_FRAME,blastMe);
		}
		private function blastMe(e:Event) {
			if (!detection) {
				if (this.hitTestObject(hitObject)) {
					//making the ball bounce off vertically
					collide=true;
					hitObject.speedY *= -1;
					gotoAndStop(2);
					deleteMotion();
					baseClip.detection=false;
					detection=true;
					point=new points();
					addChild(point);
					point.x=this.width/2;
					point.y=this.height/2;
					//
					Fakeball=new fakeball();
					parentClip.addChild(Fakeball);
					Fakeball.Paddle =paddleClip ;
					Fakeball.baseClip=parentClip;
					Fakeball.bricks=bricks;
					Fakeball.x=this.x+this.width/2;
					Fakeball.y=this.y+this.height;
					scoreboard.score+=10;
				}
			}
		}
		public function deleteMotion():void {
			removeEventListener(Event.ENTER_FRAME,blastMe);
		}
		public function set detection(_status:Boolean) {
			hitdetection=_status;
		}
		public function get detection() {
			return hitdetection;
		}
		public function removeMe() {
			__parent.removeChild(DisplayObject(this) );
		}
		public function set parentClip(_parent:Sprite) {
			__parent=_parent;
		}
		public function get parentClip():Sprite {
			return __parent;
		}
		//get object
		public function set hitObject(_hitObject:MovieClip) {
			__hitObject=_hitObject;
		}
		public function get hitObject():MovieClip {
			return __hitObject;
		}
		//detection test
		//detection test
		public function set baseClip(_baseClip:Sprite) {
			__baseClip=_baseClip;
		}
		public function get baseClip() {
			return __baseClip;
		}
		//paddle
		public function set paddleClip(_paddleClip:MovieClip) {
			__paddleClip=_paddleClip;
		}
		public function get paddleClip() {
			return __paddleClip;
		}
		//set bricks
		public function set bricks(_bricks:Array) {
			__bricks=_bricks;
		}
		public function get bricks():Array {
			return __bricks;
		}
		//
		public function set collide(_collide:Boolean) {
			__collide=_collide;
		}
		public function get collide():Boolean {
			return __collide;
		}
		//
		public function set scoreboard(_scoreboard:MovieClip)
		{
			__scoreboard=_scoreboard;
		}
		public function get scoreboard():MovieClip
		{
			return __scoreboard;
		}
	}
}