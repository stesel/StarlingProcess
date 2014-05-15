package objects 
{
	import components.Assets;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import natives.Native;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Sight extends Sprite
	{
		static public const OFF_TARGET	:int = 0;
		static public const ON_TARGET	:int = 1;
		
		private var sightArt:MovieClip;
		private var enemies:Sprite;
		
		public function Sight() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			createSightArt();
		}
		
		private function createSightArt():void 
		{
			sightArt = new MovieClip(Assets.getSightTextureAtlas().getTextures("Might_graphic"), 1);
			
			Mouse.hide();
			
			sightArt.x = - sightArt.width / 2;
			sightArt.y = - sightArt.height / 2;
			sightArt.currentFrame = OFF_TARGET;
			sightArt.pause();
			
			this.addChild(sightArt);
		}
		
		public function update(): void
		{
			this.x = Native.stage.mouseX;
			this.y = Native.stage.mouseY;
			checkTarget();
		}
		
		private function checkTarget():void 
		{
			if (!enemies) return;
			hitTestPoint();
		}
		
		private function hitTestPoint():void 
		{
			if (enemies.hitTest(new Point(this.x, this.y), true))
			{
				sightArt.currentFrame = ON_TARGET;
				//trace("onTarget");
			}
			else
			{
				sightArt.currentFrame = OFF_TARGET;
				//trace("OffTarget");
			}
		}
		
		public function attachEnemies(enemies:Sprite):void 
		{
			this.enemies = enemies;
		}
		
	}

}