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
	public class CameraProxy extends Proxy implements IProxy 
	{
		// Cannonical name
		public static const NAME:String = "CameraProxy";
		
		/**
		 * Constructor
		 */
		public function CameraProxy(position:PositionVO) {
			super(NAME, position);
			Voyage.debug(this, "Created: " + NAME);
		}
		
		
		/**
		 * Position VO
		 */
		public function get position():PositionVO		{ return data as PositionVO; }
	}
}