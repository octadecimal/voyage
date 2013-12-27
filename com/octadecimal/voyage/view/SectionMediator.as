/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.sections.*;
	
	/**
	 * A Mediator
	 */
	public class SectionMediator extends Mediator implements IMediator 
	{
		
		public function SectionMediator(name:String) 
		{
			super(name, viewComponent);
			Voyage.debug(this, "Created: " + name);
			
			updatePosition();
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
        
		// NOTIFICATIONS
		// =========================================================================================
		
		/**
		 * Notification interests.
		 */
		override public function listNotificationInterests():Array {
			return [Voyage.SECTION_READY, Voyage.STAGE_RESIZED, Voyage.CAMERA_MOVE_COMPLETE];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {     
				
				case Voyage.SECTION_READY:
				
					if (note.getBody() as String == proxy.path) build();
					break;
				
				
				case Voyage.STAGE_RESIZED:
					
					updatePosition();
					break;
				
				
				case Voyage.CAMERA_MOVE_COMPLETE:
					
					var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
					if (proxy.path != site.activeSection) destroy();
					break;
			}
		}
		
		private function updatePosition():void
		{
			proxy.bounds.x = proxy.gridX * stage.width;
			proxy.bounds.x += (stage.width  - Voyage.CONTENT_WIDTH)  * 0.5;
			
			proxy.bounds.y = proxy.gridY * stage.height;
			proxy.bounds.y += (stage.height - Voyage.CONTENT_HEIGHT) * 0.5;
			proxy.bounds.y += 100;
		}
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		protected function build():void
		{
			// Update position
			updatePosition();
			
			// Move camera to this section
			sendNotification(Voyage.CAMERA_MOVE, new PositionVO(stage.width * proxy.gridX, stage.height * proxy.gridY));
			
			// Add assets to world
			for (var i:uint = 0, c = proxy.numAssets; i < c; i++)
				sendNotification(Voyage.ADD_TO_WORLD, proxy.getAssetByIndex(i));
			
			Voyage.debug(this, "Built: " + getMediatorName());
		}
		
		public function destroy():void
		{
			Voyage.debug(this, "Destroying: " + getMediatorName());
			
			// Remove assets to world
			//for (var i:uint = 0, c = proxy.numAssets; i < c; i++)
				//sendNotification(Voyage.REMOVE_FROM_WORLD, proxy.getAssetByIndex(i));
			
			// Unregister with facade
			//facade.removeProxy(getMediatorName());
			//facade.removeMediator(getMediatorName());
			
			// Clear cache
			//_proxy = null;
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Cache: proxy (SectionProxy)
		 */
		protected function get proxy():SectionProxy { if (!_proxy) _proxy = facade.retrieveProxy(getMediatorName()) as SectionProxy; return _proxy; }
		private var _proxy:SectionProxy;
		
		/**
		 * Cache: stage (StageMediator)
		 */
		private function get stage():StageMediator { if (!_stage) _stage = facade.retrieveMediator(StageMediator.NAME) as StageMediator; return _stage; }
		private var _stage:StageMediator;

	}
}
