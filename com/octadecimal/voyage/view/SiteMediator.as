/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view
{
	import com.octadecimal.voyage.model.SiteProxy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.*;
	
	/**
	 * A Mediator
	 */
	public class SiteMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "SiteMediator";
		
		
		/**
		 * Constructor.
		 */
		public function SiteMediator() 
		{
			super(NAME);
			Voyage.debug(this, "Created: " + NAME);
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
			return [Voyage.SITE_PRELOADED, Voyage.SITE_BUILD];
		}

		/**
		 * Notification handling.
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {           
				
				case Voyage.SITE_PRELOADED:
					
					// Set proxy loaded to true
					proxy.loaded = true;
					
					// Build site
					sendNotification(Voyage.SITE_BUILD);
					
					break;
				
				
				case Voyage.SITE_BUILD:
					
					// Build site
					build();
					
					break;
			}
		}
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		private function build():void
		{
		}
		
		private function destroy():void
		{
			// Clear cache
			_proxy = null;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Get the Mediator name.
		 */
		override public function getMediatorName():String { return SiteMediator.NAME; }
		
		/**
		 * Cache: proxy (SiteProxy)
		 */
		private function get proxy():SiteProxy { if (!_proxy) _proxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy; return _proxy; }
		private var _proxy:SiteProxy;
	}
}
