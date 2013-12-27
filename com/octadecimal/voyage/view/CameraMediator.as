/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.model.CameraProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class CameraMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "CameraMediator";
		
		public function CameraMediator() {
			super(NAME);
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return CameraMediator.NAME;
			updatePosition();
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
			return [Voyage.STAGE_RESIZED, Voyage.CAMERA_UPDATE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				//case Voyage.CAMERA_UPDATE:
				case Voyage.STAGE_RESIZED:
					updatePosition();
					break;
			}
		}
		
		private function updatePosition():void
		{			
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			
			// Scale world position by change
			if (_lastStageWidth) {
				var changeX:Number = stage.width  / _lastStageWidth;
				var changeY:Number = stage.height / _lastStageHeight;
				
				proxy.position.worldX *= changeX;
				proxy.position.worldY *= changeY;
			}
			
			// Save
			_lastStageWidth = stage.width;
			_lastStageHeight = stage.height;
		}
		
		private var _lastStageWidth:Number, _lastStageHeight:Number;
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cache: proxy (CameraProxy)
		 */
		private function get proxy():CameraProxy { if (!_proxy) _proxy = facade.retrieveProxy(CameraProxy.NAME) as CameraProxy; return _proxy; }
		private var _proxy:CameraProxy;

	}
}
