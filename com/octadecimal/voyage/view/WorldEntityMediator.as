/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.model.CameraProxy;
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.model.WorldEntityProxy;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	
	/**
	 * A Mediator
	 */
	public class WorldEntityMediator extends Mediator implements IMediator 
	{
		
		public function WorldEntityMediator(name:String, viewComponent:Object) {
			super(name, viewComponent);
			Voyage.debug(this, "Created entity: " + name);
			
			// Initial position
			var sectionProxy:SectionProxy = facade.retrieveProxy(proxy.section) as SectionProxy;
			if (sectionProxy) {
				updatePosition();
			}
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		private function updatePosition():void
		{
			if (view == null || proxy.position == null || sectionProxy == null) return;
			
			var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
			
			proxy.position.worldX = sectionProxy.bounds.x + proxy.position.localX;
			proxy.position.worldY = sectionProxy.bounds.y + proxy.position.localY;
			
			view.x = proxy.position.worldX - camera.worldX;
			view.y = proxy.position.worldY - camera.worldY;
		}
		
		
		
        
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
				
				case Voyage.STAGE_RESIZED:
				case Voyage.CAMERA_UPDATE:
					updatePosition();
					break;		
			}
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Utility accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite }
		
		/**
		 * Cache: proxy (WorldEntityProxy)
		 */
		private function get proxy():WorldEntityProxy { if (!_proxy) _proxy = facade.retrieveProxy(getMediatorName()) as WorldEntityProxy; return _proxy; }
		private var _proxy:WorldEntityProxy;
		
		/**
		 * Cache: sectionProxy (SectionProxy)
		 */
		private function get sectionProxy():SectionProxy { if (!_sectionProxy) _sectionProxy = facade.retrieveProxy(proxy.section) as SectionProxy; return _sectionProxy; }
		private var _sectionProxy:SectionProxy;
		
		/**
		 * Cache: camera (PositionVO)
		 */
		private function get camera():PositionVO { if (!_camera) _camera = CameraProxy(facade.retrieveProxy(CameraProxy.NAME)).getData() as PositionVO; return _camera as PositionVO; }
		private var _camera:PositionVO;
	}
}
