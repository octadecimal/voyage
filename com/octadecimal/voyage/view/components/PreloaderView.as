package com.octadecimal.voyage.view.components 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class PreloaderView extends Sprite
	{
		private var _label:LabelView = new LabelView("Loading: 0%", 18, "Myriad Pro", true, 0xFFFFFF);
		private var _shape:Sprite = new Sprite();
		
		public function PreloaderView() 
		{
			_label.x = 25;
			_label.setLetterSpacing( -0.5);
			alpha = 0;
			addChild(_label);
			
			_shape.graphics.beginFill(0xFFFFFF);
			_shape.graphics.drawRect(0, 0, _label.width, 3);
			_shape.graphics.endFill();
			addChild(_shape);
			_shape.scaleX = 0;
			_shape.x = _label.x;
			_shape.y = _label.y + _label.height +  5;
		}
		
		public function show():void
		{
			TweenLite.to(this, 2, { alpha: 1 } );
		}
		
		public function hide():void
		{
			TweenLite.to(this, .5, { alpha: 0 } );
			setPercent(0);
		}
		
		public function setPercent(value:Object):void
		{
			var percent:Number = int(value);
			_label.setText("Loading: " + percent.toString() + "%");
			_label.setLetterSpacing( -0.5);
			
			TweenLite.to(_shape, 3, { scaleX:percent / 100, ease: "easeInOut" } );
		}
		
	}

}