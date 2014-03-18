package natives 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class BoundRectangle extends Sprite
	{
		private var boundRect:Sprite;
		
		public function BoundRectangle() 
		{
			boundRect = new Sprite();
			boundRect.graphics.clear();
			boundRect.graphics.lineStyle(2, 0x0fff00);
			this.addChild(boundRect);
		}
		
		public function redraw(_x:Number, _y:Number, _w:Number, _h:Number):void
		{
			boundRect.graphics.clear();
			boundRect.graphics.lineStyle(2, 0x0fff00);
			boundRect.graphics.drawRect( _x, _y, _w, _h);
		}
		
	}

}