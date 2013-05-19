package game {
	import flash.display.*;
	import flash.events.*;
	import game.bricks.*;
	import game.*;
	import flash.text.TextField;


	public class AllBricks extends Sprite{
		
		private var brGame:BrickBreaker;
		private var bricksArray:Array=new Array();
            
		public function AllBricks(g:BrickBreaker) {
			super();
			brGame = g;
			brGame.addChild(this);			
			x=0;
			y=0;			
			attachBricks();
		}
		
		public function attachBricks():void {
			var _xdistance:Number=0;
			var _ydistance:Number=0;
			bricksArray=[];

			//adding different bricks on to the stage
			for (var i:int=0; i<50; i++) {
				var brick:MovieClip;
				bricksArray.push(brick);
				var id:Number= randRange(1,5);
				switch (id) {
					case 1 :
						brick=new blue(brGame);
						brick.hitObject=brGame.getBall();
						brick.parentClip=this;
						brick.baseClip=brGame;
						//brick.paddleClip=Paddle;
						//brick.bricks=bricksArray;
						break;
					case 2 :
						brick=new cyan(brGame);
						brick.hitObject=brGame.getBall();
						brick.parentClip=this;
						brick.baseClip=brGame;
						//brick.paddleClip=Paddle;
						break;
					case 3 :
						brick=new red(brGame);
						brick.hitObject=brGame.getBall();
						brick.parentClip=this;
						brick.baseClip=brGame;
						//brick.paddleClip=Paddle;
						break;
					case 4 :
						brick=new green(brGame);
						brick.hitObject=brGame.getBall();
						brick.parentClip=this;
						brick.baseClip=brGame;
						//brick.paddleClip=Paddle;
						break;
					case 5 :
						brick=new yellow(brGame);
						brick.hitObject=brGame.getBall();
						brick.parentClip=this;
						brick.baseClip=brGame;
						//brick.paddleClip=Paddle;
						break;
				}
				brick.name="brick"+(i+1);
				_xdistance=i;
				_xdistance=_xdistance%10;
				brick.x=_xdistance*brick.width;
				brick.y=_ydistance;
				this.addChild(brick);
				(i+1)%10==0?_ydistance=_ydistance+brick.height:NoChange();
			}
		}
		
		private function NoChange():void { return; }		
		
		/*random generation of bricks array*/
		private function randRange(min:Number,max:Number):Number {
			var randomNum:Number=Math.floor(Math.random() * max - min + 1) + min;
			return randomNum;
		}
		
	}
	
}
