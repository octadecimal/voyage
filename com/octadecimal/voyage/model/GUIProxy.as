/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class GUIProxy extends AssetGroupProxy implements ILoadupProxy 
	{
		// Cannonical name.
		public static const NAME:String = "gui";
		
		
		/**
		 * Constructor
		 */
		public function GUIProxy() {
			super(NAME);
			Voyage.debug(this, "Created: " + NAME);
		}
		
		
		/**
		 * LoadableProxy load routine, loads the external GUI assets swf.
		 */
		override public function load():void 
		{
			// Load assets
			var request:URLRequest = new URLRequest("swf/assets_gui.swf");
			var loader:Loader = new Loader();
			loader.load(request);
			
			// Listen
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			
			super.load();
		}
		
		/**
		 * Called when this proxy has been successfully loaded.
		 * @param	e
		 */
		override protected function onLoaded(e:Event):void 
		{
			//var loader:Loader = LoaderInfo(e.currentTarget).loader;
			
			// Extract assets
			//extract(loader, "gui", "logo", new PositionVO(0, 0), true);
			//extract(loader, "gui", "logo_caption", new PositionVO(0, 32), true);
			
			// Clean
			//loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			//loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			//loader.unloadAndStop();
			
			super.onLoaded(e);
		}
	}
}