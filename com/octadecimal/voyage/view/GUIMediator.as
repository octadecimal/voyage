/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.model.GUIProxy;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class GUIMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "gui";
		
		public function GUIMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			Voyage.debug(this, "Created: " + NAME);
			
			view.y = 30;
			updatePosition();
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return GUIMediator.NAME;
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
			return [Voyage.ADD_TO_GUI, Voyage.REMOVE_FROM_GUI, Voyage.SITE_BUILD, Voyage.STAGE_RESIZED];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {          
				
				case Voyage.ADD_TO_GUI:
					Voyage.debug(this, "Adding to gui: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.addChild(note.getBody() as DisplayObject);
					break;	  
				
				case Voyage.REMOVE_FROM_GUI:
					Voyage.debug(this, "Removing from gui: " + note.getBody() + "(" + DisplayObject(note.getBody()).name+ ")");
					view.removeChild(note.getBody() as DisplayObject);
					break;
				
				case Voyage.SITE_BUILD:
					build();		
					break;
				
				case Voyage.STAGE_RESIZED:
					updatePosition();
					break;
			}
		}
		
		private function updatePosition():void
		{
			// Center view horizontally
			view.x = (stage.width  - Voyage.CONTENT_WIDTH)  * 0.5;
		}
		
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		private function build():void
		{
			// Add assets to stage
			for (var i:uint = 0; i < proxy.numAssets; i++)
				view.addChild(proxy.getAssetByIndex(i));
			
			// Temp caption adjustment
			var caption:DisplayObject = proxy.getAsset("gui_logo_caption");
			caption.y = 50;
			
			// Add view to stage
			sendNotification(Voyage.ADD_TO_STAGE, view);
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
		
		/**
		 * Cache: proxy (GUIProxy)
		 */
		private function get proxy():GUIProxy { if (!_proxy) _proxy = facade.retrieveProxy(GUIProxy.NAME) as GUIProxy; return _proxy; }
		private var _proxy:GUIProxy;
		
		/**
		 * Cache: stage (StageMediator)
		 */
		private function get stage():StageMediator { if (!_stage) _stage = facade.retrieveMediator(StageMediator.NAME) as StageMediator; return _stage; }
		private var _stage:StageMediator;
	}
}
