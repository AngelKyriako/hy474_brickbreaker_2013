package game.bricks{
	
	import game.*;
	import game.items.*;	
	
	public class red extends brick {
		
		public function red(g:BrickBreaker) {
			super(g);
		}
		
		override public function DropItem():void{
			var itm:mango = new mango(getGame());
			getGame().setPosition(itm, x+width/2 ,y+height);
		}
	}
}
