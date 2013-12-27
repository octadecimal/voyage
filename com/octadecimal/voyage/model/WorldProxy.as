/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.Voyage;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.assetloader.model.AssetProxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class WorldProxy extends AssetGroupProxy implements ILoadupProxy 
	{
		// Cannonical name
		public static const NAME:String = "world";
		
		// Bounds
		private var _bounds:Rectangle = new Rectangle();
		
		
		/**
		 * Contructor.
		 */
		public function WorldProxy(data:Object = null) {
			super(NAME);
			Voyage.debug(this, "Created: " + NAME);
		}
		
		
		/**
		 * Load method.
		 */
		override public function load():void 
		{
			var request:URLRequest = new URLRequest("swf/assets_world.swf");
			var loader:Loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			
			loader.load(request);
			
			super.load();
		}
		
		/**
		 * OnLoad method.
		 */
		override protected function onLoaded(e:Event):void 
		{
			super.onLoaded(e);
		}
		
		
		public function get bounds():Rectangle { return _bounds; }
	}
}