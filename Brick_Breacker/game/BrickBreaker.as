package game {
	import flash.display.*;
	import flash.events.*;
	import utils.*;
	import game.bricks.*;
  	import flash.ui.Keyboard;

	public class BrickBreaker extends Sprite{
		private var Paddle:MovieClip;
		private var Ball:MovieClip;
		private var speedX:Number=8;
		private var speedY:Number=8;
		private var direction:Number=-1;
		private var _base:Sprite;
		private var _clip;
		private var bricksArray:Array=new Array();
		private var Start:MovieClip;
		private var newGame:Boolean=false;
		private var __detection:Boolean=false;
		private var Less:MovieClip;
		private var Scoreboard:MovieClip;
		private var keys:Array = [];
		
		
		public function BrickBreaker() {
			stage.frameRate = 100;
			attachpaddle();
			attachball();
			attachstart();
			attachBricks();
		}
		
		private function gameBegin(e:MouseEvent) {
			removeChild(MovieClip(e.currentTarget));
			newGame=true;
			dispatchevents();
		}
		
		/* all events are declared here */
		private function dispatchevents():void {
			//all Events
			if (newGame) {
				//na valoume na epilegei mouse h' arrows
				//stage.addEventListener(MouseEvent.MOUSE_MOVE,movePaddleWithMouse); /*Event Listener for mouse*/
				stage.addEventListener(KeyboardEvent.KEY_DOWN, movePaddleWithArrowKeys); /*Event Listener for arrow keys*/
				stage.addEventListener(Event.ENTER_FRAME,moveBall);
			}
		}
		
		/*
			BRICKS
		*/
		
		public function attachBricks():void {
			var _xdistance:Number=0;
			var _ydistance:Number=0;
			bricksArray=[];
			//adding base
			_base=new Sprite();
			_base.x=0;
			_base.y=0;
			addChild(_base);

		//adding different bricks on to the stage
			for (var i:int=0; i<50; i++) {
				var brick:MovieClip;
				bricksArray.push(brick);
				var id:Number= randRange(1,5);
				switch (id) {
					case 1 :
						brick=new blue();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						brick.bricks=bricksArray;
						//brick.scoreboard=Scoreboard;
						break;
					case 2 :
						brick=new cyan();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						//brick.scoreboard=Scoreboard;
						break;
					case 3 :
						brick=new red();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						//brick.scoreboard=Scoreboard;
						break;
					case 4 :
						brick=new green();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						//brick.scoreboard=Scoreboard;
						break;
					case 5 :
						brick=new yellow();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						//brick.scoreboard=Scoreboard;
						break;
				}
				brick.name="brick"+(i+1);
				_xdistance=i;
				_xdistance=_xdistance%10;
				brick.x=_xdistance*brick.width;
				brick.y=_ydistance;
				_base.addChild(brick);
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
			Ball=new ball();
			setPosition(Ball,Paddle.x+Paddle.width/2,Paddle.y-Ball.width/2);
			Ball.speedX=speedX;
			Ball.speedY=speedY;
		 }
		
		 private function moveBall(e:Event) {
			Ball.x+=Ball.speedX;
			Ball.y+=Ball.speedY;
			//right side
			if (Ball.x>(stage.stageWidth-Ball.width/2)) {
				if (detection) {
					detection=false;
				}
				Ball.speedX*=direction;
			}
			//down side
			if (Ball.y>(stage.stageHeight+Ball.height)) {
				balllost();
			}
			//right side
			if (Ball.x<(Ball.width/2)) {
				if (detection) {
					detection=false;
				}
				Ball.speedX*=direction;
			}
			//up side
			if (Ball.y<(Ball.height/2)) {
				if (detection) {
					detection=false;
				}
				Ball.speedY*=direction;
			}
			if (Paddle.hitTestObject(Ball) && !detection) {
				changeballAngle();
				detection=true;
			}
		}
		
		//change ball angle and direction when ball collide with the paddle
		private function changeballAngle():void {

			var ballPosition:Number = Ball.x-Paddle.x;
			var hitPercent:Number = (ballPosition / (Paddle.width - Ball.width)) - .5;
			Ball.speedX = hitPercent * 10;
			//Making the ball bounce back up
			Ball.speedY *= -1;

		}
		
		private function balllost():void {
			/*chanceLost();
			if (Scoreboard.left>0) {
				Less=new less();
				setPosition(Less,500,308);
				removeevents();
				stage.addEventListener(MouseEvent.MOUSE_DOWN,resetBall);
			}*/
		}
		public function set detection(_detection:Boolean) {
			__detection=_detection;
		}
		
		public function get detection():Boolean {
			return __detection;
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
			UTILITIES
		*/
		
		private function setPosition(__object:MovieClip,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;

		}

	}
	
}
