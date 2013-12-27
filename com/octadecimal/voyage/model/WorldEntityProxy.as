/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class WorldEntityProxy extends Proxy implements IProxy 
	{
		// Section this entity belongs to
		private var _section:String;
		
		// Position
		private var _position:PositionVO;
		
		
		/**
		 * Constructor
		 */
		public function WorldEntityProxy(name:String, section:String, position:PositionVO = null) 
		{
			super(name, position);
			
			// Save section
			_section = section;
			
			Voyage.debug(this, "Created: " + name + " ("+section+")");
		}
		
		
		/**
		 * Position
		 */
		public function get position():PositionVO	{ return data as PositionVO; }
		
		/**
		 * Section this entity belongs to.
		 */
		public function get section():String		{ return _section; }
	}
}