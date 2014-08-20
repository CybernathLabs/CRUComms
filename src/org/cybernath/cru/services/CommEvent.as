package org.cybernath.cru.services
{
	import flash.events.Event;
	
	public class CommEvent extends Event
	{
		public static const CRU_MESSAGE_RECEIVED:String = 'cruMessageReceived';
		
		public var message:CRUMessage;
		
		public function CommEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}