package com.octadecimal.voyage.view.components 
{
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	
	/**
	 * Stage view, instantiated after Stage preload completes. Responsible
	 * for creating the application facade.
	 */
	public class StageView extends Sprite
	{
		public function StageView() 
		{
			// Create application facade and startup.
			Voyage.getInstance().startup(stage);
		}
	}

}