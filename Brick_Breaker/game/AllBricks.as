package game {
	import flash.display.*;
	import flash.events.*;
	import game.bricks.*;
	import game.*;
	import flash.text.TextField;


	public class AllBricks extends Sprite{
		
		private var brGame:BrickBreaker;
		private var bricksNumber:Number;
		private var bricksArray:Array=new Array();
            
		public function AllBricks(g:BrickBreaker, num:Number) {
			super();
			
			brGame = g;
			bricksNumber = num;
			
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
			for (var i:int=0; i<bricksNumber; i++) {
				var brick:MovieClip;
				bricksArray.push(brick);
				var id:Number= randRange(1,5);
				switch (id) {
					case 1 :
						brick=new blue(brGame);
						break;
					case 2 :
						brick=new cyan(brGame);
						break;
					case 3 :
						brick=new red(brGame);
						break;
					case 4 :
						brick=new green(brGame);
						break;
					case 5 :
						brick=new yellow(brGame);
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
		
		/* mutator */
		public function BrickHasBroken():void{
			--bricksNumber;
			if (brGame.HaveWinner() ){
				brGame.GameOver(true);
			}
		}
		
		/* accessor */
		public function getBricksCount():Number{ return bricksNumber; }
		
	}
	
}
