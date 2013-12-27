/*
 Mediator - PureMVC
 */
package com.octadecimal.voyage.view.sections 
{
	import com.octadecimal.voyage.model.sections.SectionHomeProxy;
	import com.octadecimal.voyage.view.SectionMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import com.octadecimal.voyage.view.sections.*;
	
	/**
	 * A Mediator
	 */
	public class SectionHomeMediator extends SectionMediator implements IMediator 
	{
		// Views
		private var _welcomeView:MovieClip;
		private var _introView:MovieClip;
		
		
		public function SectionHomeMediator(name:String) 
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
		 * Utility view accessor.
		 */
		private function get view():Sprite { return viewComponent as Sprite }
	}
}
