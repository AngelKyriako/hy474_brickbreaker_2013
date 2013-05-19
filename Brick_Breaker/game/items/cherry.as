package game.items{
	
	import flash.display.*;
	import flash.events.*;
	import game.BrickBreaker;
	
	public class cherry extends Item {
		
		public function cherry(g:BrickBreaker){
			super(g);
		}
		
		override public function itemAcquired():void{
			brGame.getScoreBoard().increaseScore(150);
		}
		
	}
}