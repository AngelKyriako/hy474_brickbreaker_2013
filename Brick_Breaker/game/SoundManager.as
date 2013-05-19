package game {
	import flash.display.Sprite; 
    import flash.media.Sound; 
    import flash.media.SoundChannel; 
	import game.*;

	public class SoundManager extends Sprite{

        public var soundClass:Class; 
         
		public function SoundManager(g:BrickBreaker) { }
		
		public static function PlayBrickBreaking(){
			var brickBreaking:Sound = new BrickBreaking();
				brickBreaking.play();
		}	
		
		public static function PlayBallBouncing(){
			var ballBouncing:Sound = new BallBouncing();
				ballBouncing.play();
		}
		
		/*public static function PlayPowerUp(){
			var powerUp:Sound = new PowerUp();
				powerUp.play();
		}
		
		public static function PlayWinSound(){
			var winningSound:Sound = new WinningSound();
				winningSound.play();
		}
		*/
		public static function PlayLoseSound(){
			var losingSound:Sound = new LosingSound();
				losingSound.play();
		}
	
	}
}