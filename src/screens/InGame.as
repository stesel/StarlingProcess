package screens 
{
	import components.Sounds;
	import events.HeroEvent;
	import flash.sampler.NewObjectSample;
	import flash.utils.setTimeout;
	import natives.Native;
	import objects.Bullet;
	import objects.Enemy;
	import objects.Explosion;
	import objects.GameBackground;
	import objects.Hero;
	import objects.Sight;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class InGame extends Sprite 
	{
		private var background:GameBackground;
		private var hero:Hero;
		private var sight:Sight;
		
		private var enemies:Vector.<Enemy>;
		private var enemiesContainer:Sprite;
		
		private var enemiesCount:TextField;
		
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
			hero.addEventListener(HeroEvent.COLLIDED, heroCollided);
			
			sight = new Sight();
			sight.x = Native.stage.mouseX;
			sight.y = Native.stage.mouseY;
			
			this.addChild(hero);
			this.addChild(sight);
			
			sounds = new Sounds();
			
			initEnemies();
			stage.addEventListener(TouchEvent.TOUCH, stage_touch);
		}
		
		
		private function initEnemies():void 
		{
			enemies = new Vector.<Enemy>();
			enemiesContainer = new Sprite();
			this.addChildAt(enemiesContainer, this.getChildIndex(hero))
			
			var count:int = 10;
			for (var i:int = 0; i < count; i++ )
			{
				var enemy:Enemy = new Enemy(hero);
				enemy.addEventListener(Enemy.DESTROY_ENEMY, onDestroyEnemy);
				enemiesContainer.addChild(enemy);
				enemies.push(enemy);
			}
			
			sight.attachEnemies(enemiesContainer);
			
			enemiesCount = new TextField(100, 20, "text", "Arial", 14, Color.AQUA, true);
			enemiesCount.hAlign = HAlign.LEFT;			
			enemiesCount.vAlign = VAlign.BOTTOM;
			addChild(enemiesCount);
			enemiesCount.y = stage.stageHeight - enemiesCount.height;
			setEnemiesCount(enemies.length);
		}
		
		private function setEnemiesCount(length:int):void 
		{
			if(length)
				enemiesCount.text = "Enemies: " + length;
			else
				enemiesCount.text = "You win!";
		}
		
		private function onDestroyEnemy(e:Event):void 
		{
			var enemy:Enemy = e.target as Enemy;
			if (!enemy) return;
			enemy.removeEventListener(Enemy.DESTROY_ENEMY, onDestroyEnemy);
			
			//Explosion//
			var explosion:Explosion = new Explosion();
			explosion.addEventListener(Explosion.REMOVE_EXPLOSION, onRemoveExplosion);
			explosion.x = enemy.x;
			explosion.y = enemy.y;
			enemiesContainer.removeChild(enemy);
			
			var index:Number = enemies.indexOf(enemy);
			if (index >-1 )
				enemies.splice(index, 1);
				
			setEnemiesCount(enemies.length);
			enemy = null;
			enemiesContainer.addChild(explosion);
		}
		
		private function onRemoveExplosion(e:Event):void 
		{
			var explosion:Explosion = e.target as Explosion;
			if (!explosion) return;
			enemiesContainer.removeChild(explosion);
			explosion = null;
		}
		
		private function heroCollided(e:HeroEvent):void 
		{
			hero.relax = true;
			hero.alpha = 0.6;
			sounds.onCollision();
			setTimeout(restoreDamage, 2000);
		}
		
		private function restoreDamage():void 
		{
			hero.relax = false;
			hero.alpha = 1;
		}
		
		private function stage_touch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			if (touch)
			{
				var bullet:Bullet = new Bullet(hero, enemies, sounds);
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