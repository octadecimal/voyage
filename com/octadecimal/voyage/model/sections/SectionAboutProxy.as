/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model.sections 
{
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class SectionAboutProxy extends SectionProxy implements ILoadupProxy 
	{
		public function SectionAboutProxy(name:String) {
			super(name);
		}
		
		override public function load():void 
		{
			super.load();
		}
		
		override protected function onLoaded(e:Event):void 
		{
			var loader:Loader = LoaderInfo(e.currentTarget).loader;
			
			// Extract assets
			//extract(loader, path, "intro", new PositionVO(0, 600+0));
			//extract(loader, path, "about", new PositionVO(0, 600+56));
			
			super.onLoaded(e);
		}
		
	}
}