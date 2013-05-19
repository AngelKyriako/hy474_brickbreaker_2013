package game.bricks{

	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.bricks.*;
	import game.BrickBreaker;
	
	public class brick extends MovieClip {
		
		private var brGame:BrickBreaker;
		private var __parent:Sprite;
		private var hitdetection=false;
		private var _banner:MovieClip;
		private var __hitObject:MovieClip;
		private var __baseClip:Sprite;
		private var point:MovieClip;
		private var __paddleClip:MovieClip;
		private var __bricks:Array;
		private var __collide:Boolean;

				
		public function brick(g:BrickBreaker) {
			brGame = g;
			collide=false;
			addEventListener(Event.ENTER_FRAME,blastMe);
		}
		
		private function blastMe(e:Event) {
			if (!detection && hitTestObject(hitObject)) {
				//making the ball bounce off vertically
				collide=true;
				brGame.getBall().MultSpeedY(-1);
				gotoAndStop(2);
				deleteMotion();
				baseClip.detection=false;
				detection=true;
				point=new points();
				addChild(point);
				point.x=this.width/2;
				point.y=this.height/2;
				brGame.getScoreBoard().increaseScore(10);
			}
		}
		
		/*mutators*/
		public function deleteMotion():void { removeEventListener(Event.ENTER_FRAME,blastMe); }
		public function removeMe() { __parent.removeChild(DisplayObject(this) ); }
		
		public function set hitObject(_hitObject:MovieClip) { __hitObject=_hitObject; }		
		public function set detection(_status:Boolean) { hitdetection=_status; }
		public function set parentClip(_parent:Sprite) { __parent=_parent; }		
		public function set baseClip(_baseClip:Sprite) { __baseClip=_baseClip; }
		public function set paddleClip(_paddleClip:MovieClip) { __paddleClip=_paddleClip; }
		public function set bricks(_bricks:Array) { __bricks=_bricks; }
		public function set collide(_collide:Boolean) { __collide=_collide; }
				
		/*accessors*/				
		public function getGame():BrickBreaker { return brGame; }
		public function get detection() { return hitdetection; }
		public function get parentClip():Sprite { return __parent; }
		public function get hitObject():MovieClip { return __hitObject; }
		public function get baseClip() { return __baseClip; }
		public function get paddleClip() { return __paddleClip; }
		public function get bricks():Array { return __bricks; }
		public function get collide():Boolean { return __collide; }				
	}
}
