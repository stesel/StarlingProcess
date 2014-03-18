package objects 
{
	import components.Assets;
	import controllers.HeroController;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import natives.BoundRectangle;
	import natives.Native;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Hero extends Sprite 
	{
		private var boundRect:BoundRectangle;
		private var heroArt:MovieClip;
		public var controller:HeroController;
		private var rectangle:Rectangle;
		
		public var relax:Boolean;
		
		public function Hero() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			createHeroArt();
		}
		
		private function createHeroArt():void 
		{
			heroArt = new MovieClip(Assets.getHeroTextureAtlas().getTextures("Hero_graphic"), 20);
			heroArt.x = Math.ceil( -heroArt.width / 2 );
			heroArt.y = Math.ceil( -heroArt.height / 2 );
			
			controller = new HeroController(this, this.stage, 0.3);
			
			Starling.juggler.add(heroArt);
			this.addChild(heroArt);
			
			boundRect = new BoundRectangle();
			Native.stage.addChild(boundRect);
		}
		
		public function update(): void
		{
			controller.update();
			//redrawRect();
		}
		
		public function collideRect():Rectangle
		{
			rectangle = heroArt.getBounds(this.parent);
			return rectangle;
		}
		
		private function redrawRect():void 
		{
			var rectangle:Rectangle = collideRect();
			boundRect.redraw( rectangle.x, rectangle.y, rectangle.width, rectangle.height );
		}
		
		override public function get width():Number { return heroArt.width };
		override public function get height():Number { return heroArt.height };
		
	}

}