package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.view.StageMediator;
	import com.octadecimal.voyage.view.WorldEntityMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.model.LoadupResourceProxy;
   
	public class LoadableProxy extends Proxy implements IProxy
	{
		/**
		 * Constructor
		 */
		public function LoadableProxy(name:String, data:Object=null)
		{
		   super(name, data);
		}
		
		/**
		 * Load routine.
		 */
		public function load():void
		{
			Voyage.debug(this, "Loading...");
		}
	   
		/**
		 * Called when assets have been loaded.
		 */
		protected function onLoaded(e:Event):void
		{
			Voyage.debug(this, "Loaded.");
			sendLoadedNotification(Voyage.RESOURCE_LOADED, getProxyName(), Voyage.RESOURCE_PREFIX + getProxyName());
		}
	   
		/**
		 * Called when an IO error has been encounted when loading.
		 */
		protected function onIOError(e:Event=null):void
		{
			Voyage.debug(this, "IOError: " + e);
		}
		
		/**
		 * Sends the loaded notification.
		 */
		private function sendLoadedNotification( noteName:String, noteBody:String, srName:String ):void
		{
			var srProxy:LoadupResourceProxy = facade.retrieveProxy( srName ) as LoadupResourceProxy;
			if (!srProxy.isTimedOut()) sendNotification( noteName, noteBody );
		}
	}
}