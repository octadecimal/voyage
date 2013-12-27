/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model.sections 
{
	import com.octadecimal.voyage.model.SectionProxy;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * A proxy
	 */
	public class SectionWorkProxy extends SectionProxy implements ILoadupProxy 
	{
		public function SectionWorkProxy(name:String) {
			super(name);
		}
		
		override public function load():void 
		{
			super.load();
		}
		
		override protected function onLoaded(e:Event):void 
		{
			super.onLoaded(e);
		}
		
	}
}