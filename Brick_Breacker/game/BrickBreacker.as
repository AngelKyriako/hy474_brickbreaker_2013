package game {
	import flash.display.*;
	import flash.events.*;
	import utils.*;
	public class BrickBreacker extends Sprite{
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
		/*Constructor*/
		public function BrickBreacker() {
			init();
		}
		/*Call all methods to init tha stage*/
		private function init() {
			stage.frameRate = 60; //mporei na min xreiazetai afou to exw valei stis ruthmiseis..
			attachpaddle();
			attachBricks();
			attachstart();
		}
		/*Attach start symbol, add an Event Listener on it
		and call the gameBegin function*/
		private function attachstart():void {
			Start=new start();
			Start.buttonMode=true;
			setPosition(Start,500,324);
			Start.addEventListener(MouseEvent.CLICK,gameBegin);
		}
		/*Attach paddle on the stage*/
		private function attachpaddle():void {
			//attach paddle on stage
			Paddle=new paddle();
			setPosition(Paddle,80,625);
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
		/*Attach bricks on the stage*/
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
						//brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						brick.bricks=bricksArray;
						//brick.scoreboard=Scoreboard;
						break;
					case 2 :
						brick=new cyan();
						//brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						//brick.scoreboard=Scoreboard;
						break;
					case 3 :
						brick=new red();
						//brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						brick.paddleClip=Paddle;
						//brick.scoreboard=Scoreboard;
						break;
					case 4 :
						brick=new green();
						//brick.hitObject=Ball;
						brick.parentClip=_base;
						brick.baseClip=this;
						//brick.scoreboard=Scoreboard;
						break;
					case 5 :
						brick=new yellow();
						//brick.hitObject=Ball;
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
		
		/*Create new Game, add an Event Listener to stage
		and call movePaddle function*/
		private function gameBegin(e:MouseEvent) {
			removeChild(MovieClip(e.currentTarget));
			newGame=true;
			dispatchevents();
		}
		//all events declare here
		private function dispatchevents():void {
			//all Events
			if (newGame) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,movePaddle);
				//stage.addEventListener(Event.ENTER_FRAME,moveBall);
			}
		}
		
		/*Move paddle function*/
		private function movePaddle(e:MouseEvent) {

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
		
		private function setPosition(__object:MovieClip,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;

		}

	}
	
}
