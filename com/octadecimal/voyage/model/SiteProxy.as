/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;

	/**
	 * Site proxy
	 */
	public class SiteProxy extends LoadableProxy implements ILoadupProxy
	{	
		// Cannonical name
		public static const NAME:String = "SiteProxy";
		
		// Loaded state
		private var _loaded:Boolean = false;
		
		// Current path
		private var _path:String;
		
		// Current section
		private var _activeSection:String;
		
		// Previous section (allows for delayed unloads)
		private var _previousSection:String;
		
		// Site sections
		private var _sectionTitles:ListProxy 	= new ListProxy("sectionTitles");
		private var _sectionProxies:ListProxy 	= new ListProxy("sectionProxies");
		private var _sectionMediators:ListProxy = new ListProxy("sectionMediators");
		//private var _sectionViews:ListProxy 	= new ListProxy("sectionViews");
		
		/**
		 * Constructor.
		 */
		public function SiteProxy(data:Object = null) {
			super(NAME, data);
			Voyage.debug(this, "Created: " + NAME);
		}
		
		override public function load():void 
		{
			super.load();
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(new URLRequest("xml/voyage.xml"));
		}
		
		override protected function onLoaded(e:Event):void 
		{
			var loader:URLLoader = e.target as URLLoader;
			
			data = new XML(loader.data);
			
			loader.removeEventListener(Event.COMPLETE, onLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.close();
			loader = null;
			
			super.onLoaded(e);
		}
		
        
		// DATA ACCESS
		// =========================================================================================
		
		/**
		 * Registers a section.
		 * @param	name		Internal section name
		 * @param	title		Section title displayed to user
		 * @param	proxy		Section proxy class
		 * @param	mediator	Section mediator class
		 */
		public function registerSection(name:String, title:String, proxy:Class, mediator:Class/*, view:Class*/):void
		{
			_sectionTitles.add(name, title);
			_sectionProxies.add(name, proxy);
			_sectionMediators.add(name, mediator);
			
			Voyage.debug(this, "Registered section: " + name + " " + proxy + " " + mediator);
		}
		
		
		/**
		 * Retreives a section name by numeric index.
		 * @param	index	Index of name to retrieve.
		 * @return	Section name.
		 */
		public function getSectionName(index:uint):String
		{
			return _sectionTitles.keys[index] as String;
		}
		
		/**
		 * Retrieves a section title by numeric index.
		 * @param	index	Index of title to retrieve
		 * @return	Title of the section as a string.
		 */
		public function getSectionTitleByIndex(index:uint):String
		{
			return _sectionTitles.items[index] as String;
		}
		
		/**
		 * Retrieves a section title by key name.
		 * @param	name	The section key.
		 * @return	Title of the section.
		 */
		public function getSectionTitle(name:String):String
		{
			return _sectionProxies.find(name) as String;
		}
		
		/**
		 * Retrieves the section proxy class by key name.
		 * @param	name	The section key.
		 * @return	The section proxy class to instantiate.
		 */
		public function getSectionProxy(name:String):Class
		{
			return _sectionProxies.find(name) as Class;
		}
		
		/**
		 * Retrieves the section mediator class by key name.
		 * @param	name	The section key.
		 * @return	The section mediator class to instantiate.
		 */
		public function getSectionMediator(name:String):Class
		{
			return _sectionMediators.find(name) as Class;
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Returns the currently loaded path.
		 */
		public function get path():String						{ return _path; }
		
		/**
		 * Sets the current path.
		 */
		public function set path(a:String):void 				{ _path = a; 	}
		
		
		/**
		 * Returns true if the site is loaded.
		 */
		public function get loaded():Boolean					{ return _loaded; }
		 
		/**
		 * Sets the site loaded state.
		 */
		public function set loaded(a:Boolean):void  			{ _loaded = a;	  }
		
		
		/**
		 * Returns the active section.
		 */
		public function set activeSection(a:String):void		{ _activeSection = a; Voyage.debug(this, "Active section set: " + a); }
		
		/**
		 * Sets the active section.
		 */
		public function get activeSection():String				{ return _activeSection; }
		
		
		/**
		 * Returns the previous section.
		 */
		public function set previousSection(a:String):void		{ _previousSection = a; Voyage.debug(this, "Previous section set: " + a); }
		
		/**
		 * Sets the previous section.
		 */
		public function get previousSection():String			{ return _previousSection; }
		
		
		/**
		 * Returns the total number of site sections.
		 */
		public function get numSections():uint					{ return _sectionTitles.length; }
		
	}
}