package game {
	import flash.display.*;
	import flash.events.*;
	import game.bricks.*;
	import game.*;
	import flash.text.TextField;


	public class BrickBreaker extends Sprite{
		
		private var allBricks:AllBricks;
		private var Paddle:paddle;
		private var Ball:ball;
		private var Score:ScoreBoard;
		private var __detection:Boolean;		
		private var Start:MovieClip;
		private var newGame:Boolean;
            
		public function BrickBreaker() {
			stage.frameRate = 100;
			attachpaddle();
			attachball();
			attachstart();
			allBricks = new AllBricks(this);
			attachScoreBoard();
			newGame = false;
		}
		
		
		private function gameBegin(e:MouseEvent) {
			removeChild(MovieClip(e.currentTarget));
			newGame=true;
			dispatchevents();
		}
		
		/* all events are declared here */
		public function dispatchevents():void {
			//all Events
			if (newGame) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,Paddle.movePaddleWithMouse); /*Event Listener for mouse*/
				stage.addEventListener(KeyboardEvent.KEY_DOWN, Paddle.movePaddleWithArrowKeys); /*Event Listener for arrow keys*/
				stage.addEventListener(Event.ENTER_FRAME,Ball.moveBall);
			}
		}
		
		public function removeevents() {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,Paddle.movePaddleWithMouse);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,Paddle.movePaddleWithArrowKeys);
			stage.removeEventListener(Event.ENTER_FRAME,Ball.moveBall);
		}
		
		/*
			PADDLE
		*/
		private function attachpaddle():void {
			Paddle=new paddle(this);
			setPosition(Paddle,80,625);
		}
		
		/*
			BALL
		*/
		
		 private function attachball() {
			Ball=new ball(this);
			setPosition(Ball,Paddle.x+Paddle.width/2,Paddle.y-Ball.width/2);
			__detection = false;
		 }
		
		/*
			START
		*/
		
		private function attachstart():void {
			Start=new start();
			Start.buttonMode=true;
			setPosition(Start,500,324);
			Start.addEventListener(MouseEvent.CLICK,gameBegin);
		}
		
		/*
			SCOREBOARD
		*/
		private function attachScoreBoard(){
			 Score = new ScoreBoard(this);
			 
			 Score.setTextFieldFormat(Score.getcurrentScoreField());
			 Score.setTextFieldFormat(Score.getcurrentLifesField());
			 
			 setTextFieldPosition(Score.getcurrentScoreField(),10,580);
			 setTextFieldPosition(Score.getcurrentLifesField(),10,620);
			 
			 addEventListener(Event.ENTER_FRAME, showScore, false, 0, true);
			 addEventListener(Event.ENTER_FRAME, showLifes, false, 0, true);
		}
		
        private function showScore(event:Event):void
        {
            Score.setcurrentScoreField(Score.addCommas(Score.getScore()));
        }
        
		private function showLifes(event:Event):void
        {
            Score.setcurrentLifesField(Score.addCommas(Score.getLifes()));
        }
		
		/*
			UTILITIES
		*/
		
		public function setPosition(__object:MovieClip,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;

		}
		
		public function setTextFieldPosition(__object:TextField,__x:Number,__y:Number) {
			__object.textColor = 0xFF0000;
			addChild(__object);
			__object.x=__x;
			__object.y=__y;

		}
		
		
		/* mutators */
		public function setNewGame(b:Boolean){ newGame = b; }
		public function set detection(_detection:Boolean) { __detection=_detection; }

		/* accessors */		
		public function getScoreBoard():ScoreBoard{ return Score; }
		public function getPaddle():paddle{ return Paddle; }
		public function getBall():ball{ return Ball; }
		public function get detection():Boolean { return __detection; }
		
	}
	
}
