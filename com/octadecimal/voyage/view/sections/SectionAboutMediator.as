/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view.sections 
{
	import com.octadecimal.voyage.view.SectionMediator;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.sections.*;
	
	/**
	 * A Mediator
	 */
	public class SectionAboutMediator extends SectionMediator implements IMediator 
	{
		// Views
		private var _introView:MovieClip;
		private var _aboutView:MovieClip;
		
		
		public function SectionAboutMediator(name:String) 
		{	
			super(name);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		
		
		// VIEW MANIPULATION
		// =========================================================================================
		
		
		
		// BUILD/DESTROY
		// =========================================================================================
		
		override protected function build():void 
		{
			
			super.build();
		}
		
		override public function destroy():void 
		{
			
			super.destroy();
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		
		/**
		 * Utility accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite }

	}
}
