/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class NavigationMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "NavigationMediator";
		
		public function NavigationMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			Voyage.debug(this, "Created: " + NAME);
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return NavigationMediator.NAME;
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
			return [Voyage.SITE_BUILD, Voyage.STAGE_RESIZED];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {   
				
				case Voyage.SITE_BUILD:
					build();
					break;
					
				case Voyage.STAGE_RESIZED:
					var stage:StageMediator = note.getBody() as StageMediator;
					//view.x = stage.width - view.width - 10;
					break;
			}
		}
		
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		private function build():void
		{
			// Add view to stage
			sendNotification(Voyage.ADD_TO_GUI, view);
			
			// Set initial position
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			view.x = Voyage.CONTENT_WIDTH - view.width;
			view.y = 32;
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
