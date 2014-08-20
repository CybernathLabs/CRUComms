package org.cybernath.cru.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	public class Comms extends EventDispatcher
	{
		private static var _instance:Comms;
		
		public var connected:Boolean = false;
		
		private var _nc:NetConnection;
		private var _ng:NetGroup;
		
		public function Comms(caller:Function)
		{
			if (caller != preventCreation) {
				throw new Error("Creation of Comms without calling getInstance() is not valid");
			}
			init();
		}
		
		private static function preventCreation():void{}
		
		public static function getInstance():Comms
		{
			if(!_instance)
			{
				_instance = new Comms(preventCreation);
			}
			
			return _instance;
		}
		
		private function init():void{
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			_nc.connect("rtmfp:");
		}
		
		private function onNetStatus(event:NetStatusEvent):void
		{
			trace("COMMS Net Status: ",event.info.code,event.info.neighbor);
			switch(event.info.code){
				case "NetConnection.Connect.Success":
					setupNetGroup();
					break;
				
				case "NetGroup.Connect.Success":
					connected = true;
					break;
				
				case "NetGroup.Posting.Notify":
					receiveMessage(event.info.message);
					break;
			}			
		}
		
		private function receiveMessage(msg:Object):void
		{
			trace("Message Received!",msg);
			var evt:CommEvent = new CommEvent(CommEvent.CRU_MESSAGE_RECEIVED);
			evt.message = new CRUMessage(msg); 
			dispatchEvent(evt);
		}
		
		public function postMessage(message:CRUMessage):void
		{
			_ng.post(message.messageObject);
		}
		
		public function sendString(message:String):void
		{
			var m:CRUMessage = new CRUMessage();
			m.type = CRUMessage.CRU_EVENT;
			m.value = message;
			
			postMessage(m);
		}
		
		private function setupNetGroup():void
		{
			var groupspec:GroupSpecifier = new GroupSpecifier("cruGroup/cruDisplay");
			groupspec.postingEnabled = true;
			groupspec.ipMulticastMemberUpdatesEnabled = true;
			groupspec.addIPMulticastAddress("225.225.0.1:30303");
			
			_ng = new NetGroup(_nc,groupspec.groupspecWithAuthorizations());
			_ng.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
		}
	}
}