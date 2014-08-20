package org.cybernath.cru.services
{
	public class CRUMessage
	{
		
		private var _msgObj:Object;
		
		// This message type is for the display to notify the consoles of something.
		// Planned usage is to acknowledge that instructions have begun playing on the main screen.
		public static const NOTIFY_CRU:String = "CRU.NotifyConsole";
		
		// These messages are likely to be used during the course of a typical game.
		public static const CRU_GAME_OVER:String = "CRU.Game.End";
		public static const CRU_ANSWER_CORRECT:String = "CRU.Event.CorrectAnswer";
		public static const CRU_ANSWER_WRONG:String = "CRU.Event.WrongAnswer";
		public static const CRU_GAME_BEGIN:String = "CRU.Game.Begin";
		
		// These messages are intended for generic notifications that do not match the above.
		public static const CRU_EVENT:String = "CRU.Event";
		public static const CRU_UPDATE:String = "CRU.Update";
		
		public function CRUMessage(obj:Object = null)
		{
			if(obj){
				_msgObj = obj;
			}else{
				_msgObj = {threatLevel:-1};
			}
		}
		
		public function get messageObject():Object
		{
			return _msgObj;
		}
		
		public function set messageObject(value:Object):void
		{
			_msgObj = value;
		}
		
		public function get type():String
		{
			return _msgObj.type;
		}
		public function set type(value:String):void
		{
			_msgObj.type = value;
		}
		
		
		public function get value():String
		{
			return _msgObj.msgValue;
		}
		public function set value(val:String):void
		{
			_msgObj.msgValue = val;
		}
		
		public function get correctAnswers():int
		{
			return _msgObj.correctAnswers;
		}
		public function set correctAnswers(value:int):void
		{
			_msgObj.correctAnswers = value;
		}
		
		public function get wrongAnswers():int
		{
			return _msgObj.wrongAnswers;
		}
		public function set wrongAnswers(value:int):void
		{
			_msgObj.wrongAnswers = value;
		}
		
		public function get threatLevel():int
		{
			return _msgObj.threatLevel;
		}
		public function set threatLevel(value:int):void
		{
			_msgObj.threatLevel = value;
		}
		
		public function get delay():Number
		{
			return _msgObj.delay;
		}
		public function set delay(value:Number):void
		{
			_msgObj.type = delay;
		}
		
	}
}