/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.octadecimal.voyage.Voyage;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * A Mediator
	 */
	public class StageMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "StageMediator";
		
		// Stage bounds
		private var _bounds:Rectangle = new Rectangle();
		
		
		/**
		 * Constructor.
		 * @param	viewComponent	Stage reference.
		 */
		public function StageMediator(viewComponent:Object) 
		{
			super(NAME, viewComponent);
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onSWFAddressChange);
			view.addEventListener(Event.RESIZE, onStageResize);
			
			Voyage.debug(this, "Created: " + NAME);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		/**
		 * Called when an SWFAddress.change event is detected.
		 * @param	e
		 */
		private function onSWFAddressChange(e:SWFAddressEvent):void 
		{
			Voyage.debug(this, "Path changed: " + e.path);
			sendNotification(Voyage.PATH_CHANGED, e.path);
		}
		
		/**
		 * Called when the stage has been resized.
		 * @param	e
		 */
		private function onStageResize(e:Event):void 
		{
			_bounds.width  = width;
			_bounds.height = height;
			
			sendNotification(Voyage.STAGE_RESIZED, _bounds);
		}
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Voyage.ADD_TO_STAGE, Voyage.REMOVE_FROM_STAGE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case Voyage.ADD_TO_STAGE:
					Voyage.debug(this, "Adding to stage: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.addChild(note.getBody() as DisplayObject);
					break;
				
				case Voyage.REMOVE_FROM_STAGE:
					Voyage.debug(this, "Removing from stage: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.removeChild(note.getBody() as DisplayObject);
					break;
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String 	{ return StageMediator.NAME; }
		
		/**
		 * Utility view accessor.
		 */
		private function get view():Stage 					{ return viewComponent as Stage }
		
		/**
		 * Stage width.
		 */
		public function get width():Number 					{ return view.stageWidth; }
		
		/**
		 * Stage height.
		 */
		public function get height():Number 				{ return view.stageHeight; }
		
		/**
		 * Returns the stage bounds rectangle.
		 */
		public function get bounds():Rectangle				{ return _bounds; }

	}
}
