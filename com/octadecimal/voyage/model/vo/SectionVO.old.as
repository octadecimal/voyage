package com.octadecimal.voyage.model.vo 
{
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.view.SectionMediator;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class SectionVO
	{
		public var name:String;
		public var proxy:SectionProxy;
		public var mediator:SectionMediator;
		public var view:Sprite;
		public var proxyClass:Class;
		public var mediatorClass:Class;
		
		public function SectionVO(name:String=null, proxyClass:Class=null, mediatorClass:Class=null) 
		{
			this.name = name;
			this.proxyClass = proxyClass;
			this.mediatorClass = mediatorClass;
		}
		
	}

}