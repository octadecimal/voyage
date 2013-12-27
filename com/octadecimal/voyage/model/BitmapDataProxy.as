/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.Voyage;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class BitmapDataProxy extends Proxy implements IProxy 
	{
		private var _buffer:BitmapData;
		public function get buffer():BitmapData { return _buffer; }
		
		public function BitmapDataProxy(name:String, source:DisplayObject, data:Object = null) 
		{
			super(name, data);
			
			_buffer = new BitmapData(source.width, source.height, true, 0x0);
			_buffer.draw(source);
			
			Voyage.debug(this, "Created buffer from source: " + source.name + "->" + source);
		}
		
	}
}