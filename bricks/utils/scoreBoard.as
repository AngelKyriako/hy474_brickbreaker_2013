package utils{
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.display.Sprite;
	public class scoreBoard extends MovieClip {
		private var __level:Number=0;
		private var __score:Number=0;
		private var __left:Number=0;
		private var __bonus:Number=0;
		public function scoreBoard() {
			init();
		}
		public function init() {
			level=0;
			score=0;
			left=3;
			bonus=0;
		}
		//level
		public function set level(_level:Number) {
			__level=_level;
			this.slevel.htmlText="level:-"+__level;
		}
		public function get level():Number {
			return __level;
		}
		//
		//level
		public function set score(_score:Number) {
			__score=_score;
			this.sscore.htmlText="Score:-"+__score;
		}
		public function get score():Number {
			return __score;
		}
		//level
		public function set left(_left:Number) {
			__left=_left;
			this.sleft.htmlText="Chance:-"+__left;
		}
		public function get left():Number {
			return __left;
		}
		//
		//level
		public function set bonus(_bonus:Number) {
			__bonus=_bonus;
			this.sbonus.htmlText="Score:-"+__bonus;
		}
		public function get bonus():Number {
			return __bonus;
		}
		//
	}
}