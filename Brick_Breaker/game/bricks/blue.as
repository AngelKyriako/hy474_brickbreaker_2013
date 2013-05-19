package game.bricks{
	
	import game.bricks.brick;
	import game.BrickBreaker;
	import game.items.*;
	
	public class blue extends brick {
				
		public function blue(g:BrickBreaker) {
			super(g);
		}
		
		override public function DropItem():void{
			var itm:cherry = new cherry(getGame());
			getGame().setPosition(itm, x+width/2 ,y+height);
		}
	}
}
