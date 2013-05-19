package game {
	import flash.display.*;
	import flash.events.*;
	import game.*;


	public class ball extends MovieClip{
		
		private var brGame:BrickBreaker;
		private var speedX:Number;
		private var speedY:Number;
		private var direction:Number;
		private var lostBall:MovieClip;
		
		public function ball(g:BrickBreaker) {
			super();
			brGame = g;
			speedX = 8;
			speedY = 8;
			direction = -1;
		}
		
		public function moveBall(e:Event) {
			x+=speedX;
			y+=speedY;
			//right side
			if (x>(brGame.stage.stageWidth - width/2)) {
				if (brGame.detection) {
					brGame.detection = false;
				}
				speedX*=direction;
			}
			//down side
			if (y>(brGame.stage.stageHeight + height)) {
				balllost();
			}
			//right side
			if (x<(width/2)) {
				if (brGame.detection) {
					brGame.detection = false;
				}
				speedX*=direction;
			}
			//up side
			if (y<(height/2)) {
				if (brGame.detection) {
					brGame.detection = false;
				}
				speedY*=direction;
			}
			if (brGame.getPaddle().hitTestObject(this) && !brGame.detection) {
				changeballAngle();
				brGame.detection = true;
				//Sound effect
				SoundManager.PlayBallBouncing();
			}
		}
		
		//change ball angle and direction when ball collide with the paddle
		private function changeballAngle():void {

			var ballPosition:Number = x-brGame.getPaddle().x;
			var hitPercent:Number = (ballPosition / (brGame.getPaddle().width - width)) - .5;
			speedX = hitPercent * 10;
			//Making the ball bounce back up
			speedY *= -1;
		}
		
		private function balllost():void {
			
			if ( !brGame.HaveLoser() ) {
				brGame.getScoreBoard().decreaseLife();
				lostBall=new LostBall();
				brGame.setPosition(lostBall,350,450);
				brGame.removeevents();
				brGame.stage.addEventListener(MouseEvent.MOUSE_DOWN,resetBall);
			}
			else{
				brGame.GameOver(false);
			}
		}
		
		private function resetBall(e:Event):void {
			brGame.removeChild(lostBall);
			brGame.stage.removeEventListener(MouseEvent.MOUSE_DOWN,resetBall);
			brGame.setNewGame(true);
			x=brGame.getPaddle().x+brGame.getPaddle().width/2;
			y=brGame.getPaddle().y-width/2;
			brGame.dispatchevents();
		}
				
		public function MultSpeedX(mult:Number):void{ speedX *= mult; }
		public function MultSpeedY(mult:Number):void{ speedY *= mult; }
		
		/* accessors */
		public function get SpeedX():Number{ return speedX; }
		public function get SpeedY():Number{ return speedY; }
		
	}
}
