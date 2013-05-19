package game.items{
	
	import flash.display.*;
	import flash.events.*;
	import game.*;
	
	public class Item extends MovieClip {
		
		private var _brGame:BrickBreaker;
		private var speed:Number;
		
		public function Item(g:BrickBreaker) {
			_brGame = g;
			speed = 4;
			addEventListener(Event.ENTER_FRAME, moveMe);
		}
		
		public function moveMe(e:Event) {
				e.currentTarget.y>(700)?removeMe():e.currentTarget.y+=speed;
				if (e.currentTarget.hitTestObject(brGame.getPaddle() )) {
					e.currentTarget.gotoAndPlay(2);
					speed = 0;
					itemAcquired();
					removeMe();
					brGame.SoundsHolder.PlayPowerUp();
				}
		}
		
		public function itemAcquired():void{
			brGame.getScoreBoard().increaseScore(100);
		}

		public function removeMe() {
			removeEventListener(Event.ENTER_FRAME,moveMe);
			//_brGame.removeChild(DisplayObject(this) );
		}
		
		public function get brGame():BrickBreaker {
			return _brGame;
		}
		
	}
}