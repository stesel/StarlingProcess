package screens 
{
	import components.Sounds;
	import flash.sampler.NewObjectSample;
	import natives.Native;
	import objects.Bullet;
	import objects.GameBackground;
	import objects.Hero;
	import objects.Sight;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class InGame extends Sprite 
	{
		private var background:GameBackground;
		private var hero:Hero;
		private var sight:Sight;
		
		private var sounds:Sounds;
		
		public function InGame() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			drawGame();
			addListener();
		}
		
		private function drawGame():void 
		{
			trace("InGame::drawGame()");
			
			background = new GameBackground();
			this.addChild(background);
			background.activate();
			
			hero = new Hero();
			hero.x = stage.stageWidth / 2;
			hero.y = stage.stageHeight / 2;
			
			sight = new Sight();
			sight.x = Native.stage.mouseX;
			sight.y = Native.stage.mouseY;
			
			this.addChild(hero);
			this.addChild(sight);
			
			sounds = new Sounds();
			
			stage.addEventListener(TouchEvent.TOUCH, stage_touch);
			
		}
		
		private function stage_touch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			if (touch)
			{
				var bullet:Bullet = new Bullet(hero);
				this.addChildAt(bullet, this.getChildIndex(hero) - 1);
				sounds.onShoot(2);
				//sounds.onExplosion();
				//sounds.onCollision();
			}
		}
		
		private function addListener():void 
		{
			stage.addEventListener(Event.ENTER_FRAME , onEnterFrame);
		}
		
		private function onEnterFrame(e:Event = null):void 
		{
			hero.update();
			sight.update();
		}
		
	}

}