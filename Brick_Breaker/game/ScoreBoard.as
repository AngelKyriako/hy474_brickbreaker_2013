package  game{

    import flash.events.*;
    import flash.text.*;
	import game.*;
     
    public class ScoreBoard 
    {
        private var brGame:BrickBreaker;
        private var lifes:uint; 
        private var score:uint;
     	private var currentLifesField:TextField; 
        private var currentScoreField:TextField;
  
        public function ScoreBoard(g:BrickBreaker){	
			brGame = g;
			lifes = 3;
			score = 0;
			
			currentScoreField = new TextField();
			currentLifesField = new TextField();
			
			setTextFieldFormat(currentScoreField);
			setTextFieldFormat(currentLifesField);
        }
		
		public function setTextFieldFormat(txt:TextField):void{
			var textF:TextFormat = new TextFormat();
			
			textF.font = "Tahoma";         // Defines the font used
			textF.color = 0x5678fe;        // Color
			textF.size = 25;               // Text size (in pixels)
			
			txt.width = 300;
			
			txt.defaultTextFormat = textF;
		}
		
		public function showScore(event:Event):void {
            currentScoreField.text = "Score:\t" + addCommas(score);
        }
        
		public function showLifes(event:Event):void {
            currentLifesField.text = "Lifes:\t" + addCommas(lifes);
        }
 
        public function addCommas(_score:uint):String{
            //a string, which will have the score with commas
            var scoreString:String = new String();
             
            //the amount of characters our score (without commas) has
            var scoreLength:uint = _score.toString().length;
            scoreString = "";
             
            //add the commas to the string
            for (var i:uint=0; i<scoreLength; i++) { 
                if ((scoreLength-i)%3 == 0 && i != 0) {
                    scoreString += ".";
                }
                scoreString += _score.toString().charAt(i);
            }
             
            return scoreString;
        }
		public function removeScore(_score:ScoreBoard){
			currentScoreField.parent.removeChild(currentScoreField);
			currentLifesField.parent.removeChild(currentLifesField);
		}

		public function setScore(_value:uint):void{ score = _value; }
		public function setLifes(_value:uint):void{ lifes = _value; }
		public function setcurrentLifesField(_value:String):void{ currentLifesField.text = _value; }
		public function setcurrentScoreField(_value:String):void{ currentScoreField.text = _value; }
		public function increaseScore(_change:uint):void{ score += _change; }
		public function decreaseLife():void{ lifes -= 1; }
	
		public function getGame():BrickBreaker{ return brGame; }
		public function getScore():uint{ return score; }
		public function getLifes():uint{ return lifes; }	
		public function getcurrentLifesField():TextField{ return currentLifesField; }
		public function getcurrentScoreField():TextField{ return currentScoreField; }
	
	}
}
