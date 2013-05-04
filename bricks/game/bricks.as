package game{
	/*
	all required packages and classes
	-----------------------------------------------------------------------------------
	*/
	import flash.display.*;
	import flash.events.*;
	import utils.*;
	import flash.utils.Timer;
	public class bricks extends Sprite {
		private var Paddle:MovieClip;
		private var Ball:MovieClip;
		private var speedX:Number=5;
		private var speedY:Number=5;
		private var direction:Number=-1;
		private var _base:Sprite;
		private var _clip;
		private var bricksArray:Array=new Array();
		private var Start:MovieClip;
		private var newGame:Boolean=false;
		private var __detection:Boolean=false;
		private var Less:MovieClip;
		private var Scoreboard:MovieClip;
		private var nextGame:Timer;
		public function bricks() {
			init();
		}
		/*
		@function init() 
		@responsible for initialization and primary declaration
		@return type void
		-----------------------------------------------------------------------------------
		*/
		private function init() {
			
			/*
			@function startGame() 
			@responsible for game start up
			@return type void
			-----------------------------------------------------------------------------------
			*/
			startGame();
		}
		private function startGame() 
		{
			stage.frameRate = 60;
			attachScoreboard();
			/*
			attach paddle and ball
			--------------------------------------------------------------------------------------
			*/
			attachpaddle();

			//assign events
			//dispatchevents();


			//attachball();
			attachball();
			//bricks
			attachBricks();

			attachstart();

		}
		//
		private function attachScoreboard() {
			Scoreboard=new scoreBoard();
			setPosition(Scoreboard,820,620);
		}
		//
		private function attachstart():void {
			Start=new start();
			Start.buttonMode=true;
			setPosition(Start,500,324);
			Start.addEventListener(MouseEvent.CLICK,gameBegin);
		}
		private function gameBegin(e:MouseEvent) {
			removeChild(MovieClip(e.currentTarget));
			newGame=true;
			dispatchevents();
		}
		//private ball
		private function attachball() {
			Ball=new ball();
			setPosition(Ball,Paddle.x+Paddle.width/2,Paddle.y-Ball.width/2);
			Ball.speedX=speedX;
			Ball.speedY=speedY;
		}
		private function chanceLost():void {
			Scoreboard.left==0?gameOver():Scoreboard.left-=1;
		}
		//game over
		private function gameOver():void {
			removeLevel();
		}
		//remove level
		private function removeLevel():void {
			removeComponents();
		}
		//remove components
		private function removeComponents():void {
			removeevents()
			removeChild(Ball);
			removeChild(Paddle);
			removeChild(Scoreboard);
			removeTiles();
		}
		private function removeTiles():void {
			removeChild(_base);
			nextGame=new Timer(500);
			nextGame.addEventListener("timer",playgameAgain);
			nextGame.start();
		}
		private function playgameAgain(e:TimerEvent):void {
			e.currentTarget.removeEventListener("timer",playgameAgain);
			startGame();
		}
		//remove components
		private function balllost():void {
			chanceLost();
			if (Scoreboard.left>0) {
				Less=new less();
				setPosition(Less,500,308);
				removeevents();
				stage.addEventListener(MouseEvent.MOUSE_DOWN,resetBall);
			}
		}
		//
		private function resetBall(e:Event):void {
			removeChild(Less);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,resetBall);
			newGame=true;
			Ball.x=Paddle.x+Paddle.width/2;
			Ball.y=Paddle.y-Ball.width/2;
			dispatchevents();
		}
		//
		private function removeevents() {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,movePaddle);
			stage.removeEventListener(Event.ENTER_FRAME,moveBall);
		}
		//all events declare here
		private function dispatchevents():void {
			//all Events
			if (newGame) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,movePaddle);
				stage.addEventListener(Event.ENTER_FRAME,moveBall);
			}
		}
		private function movePaddle(e:MouseEvent) {

			//The paddle follows the mouse
			Paddle.x = mouseX - Paddle.width / 2;
			//If the mouse goes off too far to the left
			if (mouseX < Paddle.width / 2) {
				//Keep the paddle on stage
				Paddle.x = 0;
			}
			//If the mouse goes off too far to the right
			if (mouseX > stage.stageWidth - Paddle.width / 2) {
				//Keep the paddle on stage
				Paddle.x = stage.stageWidth - Paddle.width;
			}
			e.updateAfterEvent();


		}
		//enter frame
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
						brick.scoreboard=Scoreboard;
						break;
					case 2 :
						brick=new cyan();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						brick.scoreboard=Scoreboard;
						break;
					case 3 :
						brick=new red();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						brick.scoreboard=Scoreboard;
						break;
					case 4 :
						brick=new green();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.scoreboard=Scoreboard;
						break;
					case 5 :
						brick=new yellow();
						brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						brick.scoreboard=Scoreboard;
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
		//



		//random gen of array
		private function randRange(min:Number,max:Number):Number {
			var randomNum:Number=Math.floor(Math.random() * max - min + 1) + min;
			return randomNum;
		}
		//change ball angle and direction when ball collide with the paddle
		private function changeballAngle():void {

			var ballPosition:Number = Ball.x-Paddle.x;
			var hitPercent:Number = (ballPosition / (Paddle.width - Ball.width)) - .5;
			Ball.speedX = hitPercent * 10;
			//Making the ball bounce back up
			Ball.speedY *= -1;

		}
		private function attachpaddle():void {
			//attach paddle on stage
			Paddle=new paddle();
			setPosition(Paddle,80,625);
		}
		//attaching a object
		private function setPosition(__object:MovieClip,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;

		}
		//
		private function noChange():void {
			return;
		}
		public function set detection(_detection:Boolean) {
			__detection=_detection;
		}
		public function get detection():Boolean {
			return __detection;
		}
	}
}