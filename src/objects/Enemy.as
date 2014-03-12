package objects 
{
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import components.Assets;
	import starling.events.Event;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Enemy extends Sprite
	{
		private var enemyArt:MovieClip;
		
		private var hero:Hero;
		
		private var speed:int;
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		
		private var minX:Number;
		private var minY:Number;
		private var maxX:Number;
		private var maxY:Number;
		
		private var _active:Boolean;
		
		
		public function Enemy(hero:Hero, speed:int = 3) 
		{
			this.hero = hero;
			this.speed = speed;
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			createEnemyArt();
		}
		
		private function createEnemyArt():void 
		{
			enemyArt = new MovieClip(Assets.getHeroTextureAtlas().getTextures("Hero_graphic"), 20);
			
			enemyArt.x = Math.ceil( -enemyArt.width / 2 );
			enemyArt.y = Math.ceil( -enemyArt.height / 2 );
			
			Starling.juggler.add(enemyArt);
			this.addChild(enemyArt);
			
			minX = - enemyArt.width;
			minY = - enemyArt.height;
			maxX = stage.stageWidth + enemyArt.width;
			maxY = stage.stageHeight + enemyArt.height;
			
			var rotationRandom:int = Math.round(Math.random() * 3);
			replace();
			enable();
		}
		
		public function enable():void
		{
			_active = true;
			this.addEventListener(Event.ENTER_FRAME, this_enterFrame);
		}
		
		public function disable():void
		{
			_active = false;
			this.removeEventListener(Event.ENTER_FRAME, this_enterFrame);
		}
		
		public function deactivate():void
		{
			//clearTimeout(shootimeOut);
			//_active = false;
			//if (bullet != null)
				//return;	
			//if(_container.contains(this))
				//_container.removeChild(this);
			replace();
		}
		
		private function replace():void 
		{
			var rotationRandom:int = Math.round(Math.random() * 3);
			switch (rotationRandom)
			{
				case 0:
					this.rotation = 0;
					this.x = Math.random() * stage.stageWidth; 
					this.y = maxY;
					break;
				case 1:
					this.rotation = - Math.PI / 2;
					this.x = maxX;
					this.y = Math.random() * stage.stageHeight;
					break;
				case 2:
					this.rotation = Math.PI / 2;
					this.x = minX;
					this.y = Math.random() * stage.stageHeight;
					break;
				case 3:
					this.rotation = Math.PI;
					this.x = Math.random() * stage.stageWidth;
					this.y = minY;
					break;
				default:
					this.rotation = Math.PI;
					this.x = Math.random() * stage.stageWidth;
					this.y = minY;
			}
			
			speedX = speed * Math.sin(this.rotation);
			speedY = - speed * Math.cos(this.rotation);
		}
		
		private function this_enterFrame(e:Event):void 
		{
			this.x += speedX;
			this.y += speedY;
			//
			if (this.x < minX)
				deactivate();
			if (this.y < minY)
				deactivate();
			if (this.x > maxX)
				deactivate();
			if (this.y > maxY)
				deactivate();
				
			checkHeroCollision();
			
			//bulletControll();
		}
		
		private function checkHeroCollision():void
		{
			if (!_active)
				return;
				
			var deltaX:Number = Math.abs(this.x - hero.x);
			var deltaY:Number = Math.abs(this.y - hero.y);
				
			if(deltaX <= (enemyArt.width + hero.width) / 2 && deltaY <= (enemyArt.height + hero.height) / 2)
			{
				hero.controller.addSpeed(2*speedX, 2*speedY);
			}	
		}
		
		
		override public function get width():Number { return enemyArt.width };
		override public function get height():Number { return enemyArt.height };
	}

}