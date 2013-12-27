/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class AssetMediator extends Mediator implements IMediator 
	{
		
		public function AssetMediator(name:String, viewComponent:Object) {
			super(name, viewComponent);
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return AssetMediator.NAME;
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				default:
					break;		
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Node id. (shared with proxy)
		 */
		public function get id():String { return getMediatorName(); }
		
		/**
		 * Utility accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite }

	}
}
