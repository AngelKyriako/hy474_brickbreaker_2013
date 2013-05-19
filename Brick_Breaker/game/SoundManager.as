package game {
	import flash.display.Sprite; 
    import flash.media.Sound; 
    import flash.media.SoundMixer;
	import game.*;

	public class SoundManager extends Sprite{
         
		private var soundtrackIsActive:Boolean;		
		var brickBreaking:Sound;
		var ballBouncing:Sound;
		var powerUp:Sound;
		var winningSound:Sound;
		var losingSound:Sound;
		 
		public function SoundManager(b:Boolean) {
			soundtrackIsActive = b;
		}
		
		public function PlayBrickBreaking(){
			if (soundtrackIsActive){
				brickBreaking = new BrickBreaking();
				brickBreaking.play();
			}
		}	
		
		public function PlayBallBouncing(){
			if (soundtrackIsActive){
				ballBouncing = new BallBouncing();
				ballBouncing.play();
			}
		}
		
		public function PlayPowerUp(){
			if (soundtrackIsActive){
				powerUp = new PowerUp();
				powerUp.play();
			}
		}
		
		public function PlayWinSound(){
			if (soundtrackIsActive){
				winningSound = new WinningSound();
				winningSound.play();
			}
		}
		
		public function PlayLoseSound(){
			if (soundtrackIsActive){
				losingSound = new LosingSound();
				losingSound.play();
			}
		}
		
		public function StopSoundtrack() { SoundMixer.stopAll(); }
		
		public function setSoundtrackActive(b:Boolean):void { soundtrackIsActive = b; }
		public function IssoundtrackActive():Boolean { return soundtrackIsActive; }		
	
	}
}