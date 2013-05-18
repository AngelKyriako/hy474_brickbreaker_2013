package game {
	import flash.display.*;
	import flash.events.*;
	import game.bricks.*;
	import game.*;
  	import flash.ui.Keyboard;
	    import flash.text.TextField;


	public class BrickBreaker extends Sprite{
		private var Paddle:MovieClip;
		private var Ball:ball;
		private var __detection:Boolean;		
		private var allBricks:Sprite;
		private var bricksArray:Array=new Array();
		private var Start:MovieClip;
		private var newGame:Boolean=false;
		private var keys:Array = [];
		private var Score:ScoreBoard;
	    private static const TRANSITION_LENGTH:uint = 500;  //the amount of time (in ms) which is needed to transition from one score value to another one
            
		public function BrickBreaker() {
			stage.frameRate = 100;
			attachpaddle();
			attachball();
			attachstart();
			attachBricks();
			attachScoreBoard();
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
				stage.addEventListener(MouseEvent.MOUSE_MOVE,movePaddleWithMouse); /*Event Listener for mouse*/
				stage.addEventListener(KeyboardEvent.KEY_DOWN, movePaddleWithArrowKeys); /*Event Listener for arrow keys*/
				stage.addEventListener(Event.ENTER_FRAME,Ball.moveBall);
			}
		}
		
		public function removeevents() {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,movePaddleWithMouse);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,movePaddleWithArrowKeys);
			stage.removeEventListener(Event.ENTER_FRAME,Ball.moveBall);
		}
		
		/*
			BRICKS
		*/
		
		public function attachBricks():void {
			var _xdistance:Number=0;
			var _ydistance:Number=0;
			bricksArray=[];
			//adding base
			allBricks=new Sprite();
			allBricks.x=0;
			allBricks.y=0;
			addChild(allBricks);

		//adding different bricks on to the stage
			for (var i:int=0; i<50; i++) {
				var brick:MovieClip;
				bricksArray.push(brick);
				var id:Number= randRange(1,5);
				switch (id) {
					case 1 :
						brick=new blue(this);
						brick.hitObject=Ball;
						brick.parentClip=allBricks;
						brick.baseClip=this;
						//brick.paddleClip=Paddle;
						//brick.bricks=bricksArray;
						break;
					case 2 :
						brick=new cyan(this);
						brick.hitObject=Ball;
						brick.parentClip=allBricks;
						brick.baseClip=this;
						//brick.paddleClip=Paddle;
						break;
					case 3 :
						brick=new red(this);
						brick.hitObject=Ball;
						brick.parentClip=allBricks;
						brick.baseClip=this;
						//brick.paddleClip=Paddle;
						break;
					case 4 :
						brick=new green(this);
						brick.hitObject=Ball;
						brick.parentClip=allBricks;
						brick.baseClip=this;
						break;
					case 5 :
						brick=new yellow(this);
						brick.hitObject=Ball;
						brick.parentClip=allBricks;
						brick.baseClip=this;
						//brick.paddleClip=Paddle;
						break;
				}
				brick.name="brick"+(i+1);
				_xdistance=i;
				_xdistance=_xdistance%10;
				brick.x=_xdistance*brick.width;
				brick.y=_ydistance;
				allBricks.addChild(brick);
				(i+1)%10==0?_ydistance=_ydistance+brick.height:noChange();
			}
		}
		
		/*random generation of bricks array*/
		private function randRange(min:Number,max:Number):Number {
			var randomNum:Number=Math.floor(Math.random() * max - min + 1) + min;
			return randomNum;
		}
		/*Just return if no change*/
		private function noChange():void {
			return;
		}
		
		/*
			PADDLE
		*/
		
		private function attachpaddle():void {
			Paddle=new paddle();
			setPosition(Paddle,80,625);
		}
				
		/*Move paddle function with mouse*/
		private function movePaddleWithMouse(e:MouseEvent) {
			/*The paddle follows the mouse*/
			Paddle.x = mouseX - Paddle.width / 2;
			/*If the mouse goes off too far to the left*/
			if (mouseX < Paddle.width / 2) {
				/* the paddle on stage*/
				Paddle.x = 0;
			}
			/*If the mouse goes off too far to the right*/
			if (mouseX > stage.stageWidth - Paddle.width / 2) {
				/*Keep the paddle on stage*/
				Paddle.x = stage.stageWidth - Paddle.width;
			}
			
			e.updateAfterEvent();
		}
		/*move paddle function with keys*/
		function movePaddleWithArrowKeys(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			var prevKey:uint = e.keyCode;
			var step:uint = 18;
			switch (key){
				case Keyboard.LEFT:
					if (Paddle.x < Paddle.width / 2) {
						/*Keep the paddle on stage*/
						Paddle.x = 0;
					}
					else if (prevKey == Keyboard.RIGHT){
						Paddle.x -= (step + step);
					}
					else{
						Paddle.x -= step;
					}
				break;
				case Keyboard.RIGHT:
					if (Paddle.x > (stage.stageWidth - Paddle.width)) {
						/*Keep the paddle on stage*/
						Paddle.x = stage.stageWidth - Paddle.width;
					}
					else if (prevKey == Keyboard.LEFT){
						Paddle.x += (step + step);
					}
					else{
						Paddle.x += step;
					}
			 	break;
			}
			prevKey = key;
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
		public function getPaddle():MovieClip{ return Paddle; }
		public function getBall():MovieClip{ return Ball; }
		public function get detection():Boolean { return __detection; }
		
	}
	
}
