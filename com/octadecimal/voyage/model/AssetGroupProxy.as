/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.view.WorldEntityMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class AssetGroupProxy extends LoadableProxy implements ILoadupProxy 
	{
		// Assets list
		private var _assets:ListProxy = new ListProxy("Assets" + Math.random());
		
		// Number of registered assets
		private var _numAssets:uint;
		
		
		public function AssetGroupProxy(name:String) {
			super(name);
			
		}
		
		override public function load():void 
		{
			super.load();
		}
		
		override protected function onLoaded(e:Event):void 
		{
			var loader:Loader = LoaderInfo(e.target).loader;
			
			// Get site XML
			var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
			var xml:XML = site.getData() as XML;
			
			// Save node as proxy data
			var node:XMLList = xml.sections[getProxyName()];
			data = node;
			
			// Extract resources
			for each(var resource:XML in node.resources.children()) {
				Voyage.debug(this, "Extracting resource: " + resource.@id);
				extract(loader, getProxyName(), resource.@id, new PositionVO(resource.@x, resource.@y), (resource.@cache == "true"));
			}
			
			// Clean
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			loader.unloadAndStop();
			
			super.onLoaded(e);
		}
		
		protected function registerAsset(name:String, asset:DisplayObject):void
		{
			_numAssets++;
			_assets.add(name, asset);
			Voyage.debug(this, "Registered asset: " + name + "->" + asset);
		}
		
		/**
		 * Retrieves an asset by key name.
		 */
		public function getAsset(name:String):DisplayObject
		{
			return _assets.find(name) as DisplayObject;
		}
		
		/**
		 * Retrieves an asset by index.
		 */
		public function getAssetByIndex(index:uint):DisplayObject
		{
			return _assets.items[index] as DisplayObject;
		}
		
		
		/**
		 * Extracts an asset and returns it as a MovieClip if cache is set to false, or a Bitmap if cache is set to true.
		 * @return
		 */
		protected function extract(swf:DisplayObjectContainer, section:String, name:String, position:PositionVO=null, cache:Boolean=false):String
		{
			// Generate entity name
			var entityName:String = section + "_" + name;
			
			// Check if asset already extracted
			if (_assets.find(entityName)) { Voyage.debug(this, "Skipped asset, already registered: " + entityName); return entityName; }
			
			// Create new PositionVO if none passed
			if (!position) position = new PositionVO();
			
			// Proxy
			facade.registerProxy(new WorldEntityProxy(entityName, section, position));
			
			// View
			var root:DisplayObjectContainer = swf.getChildAt(0) as DisplayObjectContainer;
			var view:DisplayObject = (cache) ? new Bitmap(new BitmapDataProxy(name, root.getChildByName(name)).buffer) : root.getChildByName(name);
			
			// Mediator
			facade.registerMediator(new WorldEntityMediator(entityName, view));
			
			// Register asset
			registerAsset(entityName, view);
			
			// Return entity name
			return entityName;
		}
		
		
		
		/**
		 * Retrieves the number of registered assets.
		 */
		public function get numAssets():uint		{ return _numAssets; }
		
		/**
		 * The XML node associated with this asset group.
		 */
		protected function get xml():XML { return XML(data)[0] as XML; }
	}
}