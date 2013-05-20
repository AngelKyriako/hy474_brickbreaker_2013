﻿package game.bricks{

	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.bricks.*;
	import game.*;
	
	public class brick extends MovieClip {
		
		private var brGame:BrickBreaker;
		private var hitdetection=false;
		private var point:MovieClip;

				
		public function brick(g:BrickBreaker) {
			brGame = g;
			addEventListener(Event.ENTER_FRAME,blastMe);
		}
		
		private function blastMe(e:Event) {

			if (!detection && hitTestObject(brGame.getBall()) ) {
				
				// drop items sometimes
				if (brGame.randRange(1,5) == 1)
					DropItem();
				
				//making the ball bounce off vertically
				brGame.getBall().MultSpeedY(-1);
				gotoAndStop(2);
				deleteMotion();
				brGame.detection=false;
				detection=true;
				point=new points();
				addChild(point);
				point.x=this.width/2;
				point.y=this.height/2;
				brGame.getScoreBoard().increaseScore(10);
				brGame.getAllBricks().BrickHasBroken();
				
				//Sound effect
				brGame.SoundsHolder.PlayBrickBreaking();
			}
		}
		
		public function DropItem():void { /* overriden in subclasses */ }
		
		/*mutators*/
		public function deleteMotion():void { removeEventListener(Event.ENTER_FRAME,blastMe); }
		public function removeMe() { brGame.getAllBricks().removeChild(this); }
		public function set detection(_status:Boolean) { hitdetection=_status; }

				
		/*accessors*/				
		public function getGame():BrickBreaker { return brGame; }
		public function get detection() { return hitdetection; }

	}
}
