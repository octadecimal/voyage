/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.model.WorldProxy;
	import com.octadecimal.voyage.Voyage;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class WorldMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "world";
		
		public function WorldMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			Voyage.debug(this, "Created: " + NAME);
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return WorldMediator.NAME;
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
			return [Voyage.ADD_TO_WORLD, Voyage.REMOVE_FROM_WORLD, Voyage.SITE_BUILD, Voyage.STAGE_RESIZED];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case Voyage.ADD_TO_WORLD:
					Voyage.debug(this, "Adding to world: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.addChild(note.getBody() as DisplayObject);
					break;	
				
				case Voyage.REMOVE_FROM_WORLD:
					Voyage.debug(this, "Removing from world: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.removeChild(note.getBody() as DisplayObject);
					break;
				
				case Voyage.SITE_BUILD:
					build();
					break;
					
				case Voyage.STAGE_RESIZED:
					updateBounds();
					break;
			}
		}
		
		/**
		 * Updates the bounds values, derived from stage dimensions.
		 */
		private function updateBounds():void
		{
			proxy.bounds.width  = stage.width;
			proxy.bounds.height = stage.height;
		}
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		private function build():void
		{
			// Get stage ref
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			
			// Set initial world bounds (centered horizontally, aligned to top)
			proxy.bounds.width = stage.width;
			proxy.bounds.height = stage.height;
			
			// Add to stage
			sendNotification(Voyage.ADD_TO_STAGE, view);
		}
		
		private function destroy():void
		{
			// Clear cache
			_stage = null;
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite; }
		
		/**
		 * Utility proxy accessor.
		 */
		private function get proxy():WorldProxy { return facade.retrieveProxy(WorldProxy.NAME) as WorldProxy; }
		
		/**
		 * Cache: stage (StageMediator)
		 */
		private function get stage():StageMediator { if (!_stage) _stage = facade.retrieveMediator(StageMediator.NAME) as StageMediator; return _stage; }
		private var _stage:StageMediator;

	}
}
