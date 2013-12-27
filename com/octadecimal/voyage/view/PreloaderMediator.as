/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view 
{
	import com.octadecimal.voyage.model.PreloaderProxy;
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.view.components.PreloaderView;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.*;
	import org.puremvc.as3.utilities.loadup.Loadup;
	
	/**
	 * A Mediator
	 */
	public class PreloaderMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "PreloaderMediator";
		
		public function PreloaderMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			Voyage.debug(this, "Created: " + NAME);
		}

		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String {
			return PreloaderMediator.NAME;
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
			return [Voyage.SITE_PRELOAD, Loadup.LOADING_COMPLETE, Loadup.LOADING_PROGRESS];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {    
				
				case Voyage.SITE_PRELOAD:
					sendNotification(Voyage.ADD_TO_STAGE, view);
					view.show();
					var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
					view.x = stage.width / 2 - view.width / 2;
					view.y = stage.height / 2 - view.height / 2;
					proxy.loadResources();
					break;	
				
				
				case Loadup.LOADING_COMPLETE:
					
					//sendNotification(Voyage.REMOVE_FROM_STAGE, view);
					view.hide();
					
					// Send SITE_PRELOADED if initial preloaded, else send SECTION_PRELOADED
					var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
					if (!site.loaded) {
						Voyage.debug(this, "Site preloaded.");
						sendNotification(Voyage.SITE_PRELOADED);
					}
					//else {
						Voyage.debug(this, "Section preloaded: "+site.path);
						sendNotification(Voyage.SECTION_PRELOADED, site.path);
					//}
					
					// Reset preloader
					proxy.reset();
					
					break;
				
				case Loadup.LOADING_PROGRESS:
					view.setPercent(note.getBody());
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
		private function get view():PreloaderView { return viewComponent as PreloaderView }
		
		/**
		 * Utility proxy accessor.
		 */
		private function get proxy():PreloaderProxy { return facade.retrieveProxy(PreloaderProxy.NAME) as PreloaderProxy; }

	}
}
