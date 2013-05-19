package game {
	import flash.display.*;
	import flash.events.*;
	import game.*;
  	import flash.ui.Keyboard;


	public class paddle extends MovieClip{
		private var brGame:BrickBreaker;
		private var keys:Array = [];
            
		public function paddle(g:BrickBreaker) {
			brGame = g;
		}
		
				
		/*Move paddle function with mouse*/
		public function movePaddleWithMouse(e:MouseEvent) {
			/*The paddle follows the mouse*/
			this.x = brGame.mouseX - this.width / 2;
			/*If the mouse goes off too far to the left*/
			if (brGame.mouseX < this.width / 2) {
				/* the paddle on stage*/
				this.x = 0;
			}
			/*If the mouse goes off too far to the right*/
			if (brGame.mouseX > brGame.stage.stageWidth - this.width / 2) {
				/*Keep the paddle on stage*/
				this.x = brGame.stage.stageWidth - this.width;
			}
			e.updateAfterEvent();
		}
		/*move paddle function with keys*/
		public function movePaddleWithArrowKeys(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			var prevKey:uint = e.keyCode;
			var step:uint = 18;
			switch (key){
				case Keyboard.LEFT:
					if (this.x < this.width / 2) {
						/*Keep the paddle on stage*/
						this.x = 0;
					}
					else if (prevKey == Keyboard.RIGHT){
						this.x -= (step + step);
					}
					else{
						this.x -= step;
					}
				break;
				case Keyboard.RIGHT:
					if (this.x > (stage.stageWidth - this.width)) {
						/*Keep the paddle on stage*/
						this.x = stage.stageWidth - this.width;
					}
					else if (prevKey == Keyboard.LEFT){
						this.x += (step + step);
					}
					else{
						this.x += step;
					}
			 	break;
			}
			prevKey = key;
		}
		
	}
}
