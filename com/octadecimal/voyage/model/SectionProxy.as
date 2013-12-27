/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class SectionProxy extends AssetGroupProxy implements ILoadupProxy
	{
		// Site path
		private var _path:String;
		
		// Grid position
		private var _gridX:int = 0, _gridY:int = 0;
		
		// Section bounds
		private var _bounds:Rectangle = new Rectangle(0, 0, Voyage.CONTENT_WIDTH, Voyage.CONTENT_HEIGHT);
		
		
		/**
		 * Constructor
		 */
		public function SectionProxy(name:String) 
		{	
			super(name);
			Voyage.debug(this, "Created: " + name);
		}
		
		/**
		 * LoadableProxy load implementation.
		 */
		override public function load():void 
		{
			super.load();
			
			// Load
			var loader:Loader = new Loader();
			loader.load(new URLRequest("swf/assets_"+getProxyName()+".swf"));
			
			// Listen
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		/**
		 * LoadableProxy onLoaded implementation.
		 * @param	e
		 */
		override protected function onLoaded(e:Event):void 
		{
			super.onLoaded(e);
			
			_gridX = xml.@x;
			_gridY = xml.@y;
			
			sendNotification(Voyage.SECTION_READY, getProxyName());
		}
		
		
		/**
		 * Returns the currently loaded path.
		 */
		public function get path():String					{ return _path; }
		
		/**
		 * Sets the current path.
		 */
		public function set path(a:String):void 			{ _path = a; 	}
		
		/**
		 * Returns the section bounds rectangle.
		 */
		public function get bounds():Rectangle				{ return _bounds; }
		
		/**
		 * The horizontal grid position for this section.
		 */
		public function get gridX():int 					{ return _gridX; }
		
		/**
		 * The vertical grid position for this section.
		 */
		public function get gridY():int 					{ return _gridY; }
	}
}