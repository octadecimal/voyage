package com.octadecimal.voyage.model.vo 
{
	
	public class PositionVO
	{
		public var localX:Number=0, localY:Number=0, localZ:Number=0;
		public var worldX:Number=0, worldY:Number=0, worldZ:Number=0;
		
		public function PositionVO(localX:Number=0, localY:Number=0, localZ:Number=0) 
		{
			this.localX = localX;
			this.localY = localY;
			this.localZ = localZ;
		}
		
		public function toString():String 
		{
			return "x: " + localX.toFixed(2) + " y:" + localY.toFixed(2) + " z: " + localZ.toFixed(2);
		}
	}

}