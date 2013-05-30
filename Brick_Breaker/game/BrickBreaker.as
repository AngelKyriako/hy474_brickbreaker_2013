package game {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
  	import flash.ui.Keyboard;	
	import flash.text.TextField;	
	import game.bricks.*;
	import game.*;
	import game.SoundManager;


	public class BrickBreaker extends Sprite{
		
		private var allBricks:AllBricks;
		private var Paddle:paddle;
		private var Ball:ball;
		private var Score:ScoreBoard;
		private var ballReadyForBouncing:Boolean;		
		private var Start:MovieClip;
		private var WinorLost:MovieClip;
		private var newGame:Boolean;
		private var soundsHolder:SoundManager;
		private var ToggleButtonPlay:MovieClip;
        private var ToggleButtonStop:MovieClip;
		private var gameIsPaused:Boolean;
			
		public function BrickBreaker() {
			init();
		}
		
		/* initialization */
		public function init():void{
			stage.frameRate = 60;
			attachpaddle();
			attachball();
			allBricks = new AllBricks(this, 100);
			attachScoreBoard();
			attachstart();
			attachStopButton();
			newGame = false;
			gameIsPaused = false;
			soundsHolder = new SoundManager(true);
		}
		/* Paddle */
		private function attachpaddle():void {
			Paddle=new paddle(this);
			setPosition(Paddle,420,625);
		}
		
		/* Ball */
		private function attachball() {
			Ball=new ball(this);
			setPosition(Ball,Paddle.x+Paddle.width/2,Paddle.y-Ball.width/2);
			BallReadyForBouncing = true;
		}
		
		/* ScoreBoard */
		private function attachScoreBoard(){
			 Score = new ScoreBoard(this);
			 setTextFieldPosition(Score.getcurrentScoreField(),10,560);
			 setTextFieldPosition(Score.getcurrentLifesField(),10,610);
		}
		
		/*Sound Buttons*/
		public function attachPlayButton():void{
			ToggleButtonPlay = new playSounds();
			setPosition(ToggleButtonPlay,950,600);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,pressedPlay);
		}
		
		public function attachStopButton():void{
			ToggleButtonStop = new stopSounds();
			setPosition(ToggleButtonStop,950,600);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,pressedStop);
		}
		
		public function pressedPlay(e:KeyboardEvent):void{
			soundsHolder.setSoundtrackActive(true);
			if(contains(ToggleButtonPlay) && (e.keyCode == Keyboard.M)){
				removeChild(ToggleButtonPlay);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,pressedPlay);
			}
			attachStopButton();
		}
		
		public function pressedStop(e:KeyboardEvent):void{
			soundsHolder.setSoundtrackActive(false);
			if(contains(ToggleButtonStop) && (e.keyCode == Keyboard.M)){
				removeChild(ToggleButtonStop);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,pressedStop);
			}
			attachPlayButton();
		}
		
		/* Start button */
		private function attachstart():void {
			Start=new start();
			Start.buttonMode=true;
			setPosition(Start,500,324);
			Start.addEventListener(MouseEvent.CLICK,gameBegin);
		}
		
		private function gameBegin(e:MouseEvent) {
			removeChild(MovieClip(e.currentTarget));
			newGame=true;
			dispatchevents();
		}
		
		/* About events */
		public function dispatchevents():void {
			//all Events
			if (newGame) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, Paddle.movePaddleWithMouse); /*Event Listener for mouse*/
				stage.addEventListener(KeyboardEvent.KEY_DOWN, Paddle.movePaddleWithArrowKeys); /*Event Listener for arrow keys*/
				stage.addEventListener(Event.ENTER_FRAME, Ball.moveBall);
				stage.addEventListener(Event.ENTER_FRAME, Score.showScore);
			 	stage.addEventListener(Event.ENTER_FRAME, Score.showLifes);
				stage.addEventListener(KeyboardEvent.KEY_DOWN,PauseResumeGame);
			}
		}
		
		public function removeevents() {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, Paddle.movePaddleWithMouse);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, Paddle.movePaddleWithArrowKeys);
			stage.removeEventListener(Event.ENTER_FRAME, Ball.moveBall);
			stage.removeEventListener(Event.ENTER_FRAME, Score.showScore);
			stage.removeEventListener(Event.ENTER_FRAME, Score.showLifes);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,PauseResumeGame);
		}
		
		public function removesymbols(){
			removeChild(Paddle);
			removeChild(Ball);
			removeChild(allBricks);
			Score.removeScore(Score);
		}
		
		/*random generation between mix and max*/
		public function randRange(min:Number,max:Number):Number {
			var randomNum:Number=Math.floor(Math.random() * max - min + 1) + min;
			return randomNum;
		}
		
		/* pausing game */
		public function PauseResumeGame(e:KeyboardEvent):void{
			if (e.keyCode == Keyboard.P)
				gameIsPaused = !gameIsPaused;
		}

		/* ending game */
		public function GameOver(isWin:Boolean):void{
 			
			if (isWin){
				WinorLost = new WinningScreen();
				setPosition(WinorLost,120,0);
				//sound effect
				soundsHolder.PlayWinSound();
			}
			else{
				WinorLost = new LosingScreen();
				setPosition(WinorLost,120,0);
				//sound effect
				soundsHolder.PlayLoseSound();
			}
			removesymbols();
			removeevents();
			WinorLost.addEventListener(MouseEvent.MOUSE_DOWN,restart);
		}
		public function HaveWinner():Boolean { return (allBricks.getBricksCount() == 0); }
		public function HaveLoser():Boolean { return (Score.getLifes() == 0); }
		
		public function restart(e:Event):void{
			WinorLost.removeEventListener(MouseEvent.MOUSE_DOWN,restart);
			removeChild(WinorLost);
			init();
			soundsHolder.StopSoundtrack();
		}
		
		/* mutators */
		
		public function setPosition(__object:MovieClip,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;
		}
		
		public function setTextFieldPosition(__object:TextField,__x:Number,__y:Number) {
			addChild(__object);
			__object.x=__x;
			__object.y=__y;
		}
		
		public function setNewGame(b:Boolean){ newGame = b; }
		public function set BallReadyForBouncing(b:Boolean) { ballReadyForBouncing=b; }

		/* accessors */		
		
		public function getAllBricks():AllBricks{ return allBricks; }
		public function getScoreBoard():ScoreBoard{ return Score; }
		public function getPaddle():paddle{ return Paddle; }
		public function getBall():ball{ return Ball; }
		public function get BallReadyForBouncing():Boolean { return ballReadyForBouncing; }
		public function get SoundsHolder():SoundManager { return soundsHolder; }
		public function get GameIsPaused():Boolean { return gameIsPaused; }
	}
}
