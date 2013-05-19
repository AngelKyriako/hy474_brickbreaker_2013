package game.items{
	
	import flash.display.*;
	import flash.events.*;
	import game.BrickBreaker;
	
	public class bullet extends Item {
		
		public function bullet(g:BrickBreaker){
			super(g);
		}
		
		override public function itemAcquired():void{
			brGame.getScoreBoard().IncreaseLife();
		}
		
	}
}