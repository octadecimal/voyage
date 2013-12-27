/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.Loadup;
	import org.puremvc.as3.utilities.loadup.model.LoadupMonitorProxy;
	import org.puremvc.as3.utilities.loadup.model.LoadupResourceProxy;

	/**
	 * A proxy
	 */
	public class PreloaderProxy extends Proxy implements IProxy 
	{
		// Cannonical name
		public static const NAME:String = "PreloaderProxy";
		
		// Loadup monitor
		private var _monitor:LoadupMonitorProxy;
		
		/**
		 * Constructor.
		 */
		public function PreloaderProxy(data:Object = null) {
			super(NAME, data);
			
			createLoadupMonitor();
			Voyage.debug(this, "Created: " + NAME);
		}
		
		/**
		 * Resets the preloader by creating a new loadup monitor instance.
		 */
		public function reset():void
		{
			createLoadupMonitor();
			Voyage.debug(this, "Reset.");
		}
		
		/**
		 * Loads all queued resources.
		 */
		public function loadResources():void
		{
			Voyage.debug(this, "Loading resources...");
			_monitor.loadResources();
		}
		
		/**
		 * Adds a resource to be loaded.
		 * @param	resource	Resource to be loaded.
		 */
		public function addResource(resource:LoadupResourceProxy):void
		{
			Voyage.debug(this, "Added resource: " + resource.getProxyName());
			_monitor.addResource(resource);
		}
		
		/**
		 * Instantiates a new loadup monitor for later per-section preloading.
		 */
		private function createLoadupMonitor():void
		{
			if (_monitor) {
				if (_monitor.isOkToReset()) _monitor.reset();
				_monitor.closeResourceList();
				_monitor.cleanup();
				facade.removeProxy(_monitor.getProxyName());
			}
			_monitor = new LoadupMonitorProxy();
			facade.registerProxy(_monitor);
		}
	}
}