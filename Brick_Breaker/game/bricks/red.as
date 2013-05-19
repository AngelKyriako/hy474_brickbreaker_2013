package game.bricks{
	
	import game.*;
	import game.items.*;	
	
	public class red extends brick {
		
		public function red(g:BrickBreaker) {
			super(g);
		}
		
		override public function DropItem():void{
			var itm:bullet = new bullet(getGame());
			getGame().setPosition(itm, x+width/2 ,y+height);
		}
	}
}
