package game.items{
	
	import flash.display.*;
	import flash.events.*;
	import game.BrickBreaker;
	
	public class mango extends Item {
		
		public function mango(g:BrickBreaker){
			super(g);
		}
		
		override public function itemAcquired():void{
			brGame.getScoreBoard().increaseScore(50);
		}
		
	}
}