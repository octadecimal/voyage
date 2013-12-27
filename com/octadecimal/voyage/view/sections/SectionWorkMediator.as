/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view.sections 
{
	import com.octadecimal.voyage.view.SectionMediator;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.sections.*;
	
	/**
	 * A Mediator
	 */
	public class SectionWorkMediator extends SectionMediator implements IMediator 
	{	
		public function SectionWorkMediator(name:String) 
		{	
			super(name);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		
		/**
		 * Utility accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite }

	}
}
