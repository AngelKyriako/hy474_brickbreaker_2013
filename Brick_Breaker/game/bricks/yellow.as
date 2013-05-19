package game.bricks{
	
	import game.*;
	import game.items.*;	
	
	public class yellow extends brick {
		
		public function yellow(g:BrickBreaker) {
			super(g);
		}
		
		override public function DropItem():void{
			var itm:cherry = new cherry(getGame());
			getGame().setPosition(itm, x+width/2 ,y+height);
		}
	}
}
