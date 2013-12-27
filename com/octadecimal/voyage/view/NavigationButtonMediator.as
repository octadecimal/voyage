/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.asual.swfaddress.SWFAddress;
	import com.greensock.TweenLite;
	import com.octadecimal.voyage.view.components.LabelView;
	import com.octadecimal.voyage.Voyage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class NavigationButtonMediator extends Mediator implements IMediator 
	{
		private var _path:String;
		private var _title:String;
		
		public function NavigationButtonMediator(name:String, title:String, viewComponent:Object) 
		{
			_path = name;
			_title = title;
			super("navbutton_"+name, viewComponent);
			
			// Label params
			view.setFont("Myriad Pro");
			view.setBold(true);
			view.setColor(0xFFFFFF);
			view.setFontSize(18);
			view.setText(title);
			
			// Initialize view
			view.alpha = 0.7;
			view.buttonMode = true;
			view.useHandCursor = true;
			view.mouseChildren = false;
			
			// Added to stage
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Voyage.debug(this, "Created: " + getMediatorName() + " (" + title + ")");
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			view.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			view.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onMouseUp(e:MouseEvent):void 
		{
			SWFAddress.setValue(_path);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			//view.alpha = 0.9;
			TweenLite.to(view, .2, { alpha: .9 } );
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			//view.alpha = 0.7;
			TweenLite.to(view, .2, { alpha: .7 } );
		}
		
		
		
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
		private function get view():LabelView { return viewComponent as LabelView }

	}
}
