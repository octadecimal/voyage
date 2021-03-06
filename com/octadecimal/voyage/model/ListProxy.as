﻿/*
Proxy - PureMVC
*/
package com.octadecimal.voyage.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class ListProxy extends Proxy implements IProxy 
	{	
		/**
		 * Key lookup table for `items`.
		 */
		public var keys:Vector.<String> = new Vector.<String>();
		
		/**
		 * Collection of IListItems. 
		 */
		public var items:Array = new Array();
		
		/**
		 * Length
		 */
		public var length:uint = 0;
		
		
		
		/**
		 * Constructor
		 */
		public function ListProxy(name:String, data:Object = null) {
			super(name, data);
		}
		
		
		/**
		 * Adds an item to `items` and saves the key in `keys`.
		 * @param	key		Item key.
		 * @param	item	Item reference.
		 * @return  Index
		 */
		public function add(key:*, item:*=null):uint
		{
			keys.push(key);
			if (item != null) items.push(item);
			else items.push(items.length);
			length++;
			return(keys.length - 1);
		}
		
		
		/**
		 * Removes the specified IListItem from the list by key.
		 * @param	key		Item key.
		 */
		public function remove(key:String):void
		{
			
		}
		
		
		/**
		 * Finds and returns an item by key.
		 * @param	key
		 * @return	A reference to the object with a matching key.
		 */
		public function find(key:*):*
		{
			// Search through keys for match
			for (var i:uint = 0, c:uint = keys.length; i < c; i++)
				if (keys[i] == key)
					return items[i];
			
			// No matches found, return null
			return null;
		}
		
		
		public function toString():String 
		{
			var out:String = "";
			for (var i:uint = 0; i < length; i++) {
				out += "[" + i + "] " +keys[i] + "->" + items[i];
				if (i != length - 1) out += "\n";
			}
			return out;
		}
	}
}