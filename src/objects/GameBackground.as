package objects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class GameBackground extends starling.display.Sprite
	{
		private var starTexture1:Texture;
		private var starTexture2:Texture;
		
		private var image1_1:Image;
		private var image1_2:Image;
		private var image2_1:Image;
		private var image2_2:Image;
		
		private var speed1:Number = 2;
		private var speed2:Number = 4;
		
		private var images:Vector.<Image>;
		
		public function GameBackground() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			initBitmap();
		}
		
		private function initBitmap():void 
		{
			var starCont1:flash.display.Sprite = new flash.display.Sprite();
			var starCont2:flash.display.Sprite = new flash.display.Sprite();
			
			var starbitMapData1:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x000000);
			var starbitMapData2:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x000000);
			
			var starRadius:int;
			var starAmount:int = 80;
			var starX:int;
			var starY:int;
			var starColor:uint = 0xffffff;
			
			var starArray:Vector.<flash.display.Sprite> = new Vector.<flash.display.Sprite>();
			for (var i:int = 0; i < starAmount; i++)
			{
				starRadius = Math.round(Math.random()) + 1;
				starX = Math.floor(Math.random() * stage.stageWidth);
				starY = Math.floor(Math.random() * stage.stageHeight);
				
				var star:flash.display.Sprite = new flash.display.Sprite();
				star.graphics.beginFill(starColor, 1);
				star.graphics.drawCircle(0, 0, starRadius);
				star.graphics.endFill();
				star.x = starX;
				star.y = starY;
				
				if(starRadius == 1)
					starCont1.addChild(star);
				else
					starCont2.addChild(star);
					
				starArray.push(star);
			}
			
			starbitMapData1.draw(starCont1);
			starbitMapData2.draw(starCont2);
			
			var starBitMap1:Bitmap = new Bitmap(starbitMapData1);
			var starBitMap2:Bitmap = new Bitmap(starbitMapData2);
			
			starTexture1 =  Texture.fromBitmap(starBitMap1);
			starTexture2 =  Texture.fromBitmap(starBitMap2);
			
			image1_1 = new Image(starTexture1);
			
			image1_2 = new Image(starTexture1);
			image1_2.y = -stage.stageHeight;
			
			image2_1 = new Image(starTexture2);
			
			image2_2 = new Image(starTexture2);
			image2_2.y = -stage.stageHeight;
			
			images = new Vector.<Image>();
			images.push(image1_1, image1_2, image2_1, image2_2);
			
			while (starCont1.numChildren > 0)
				starCont1.removeChildAt(0)
			while (starCont2.numChildren > 0)
				starCont2.removeChildAt(0)
				
			starArray = null;
			
			starCont1 = null;
			starCont2 = null;
			
			this.addChild(image1_1);
			this.addChild(image1_2);
			this.addChild(image2_1);
			this.addChild(image2_2);
		}
		
		public function activate():void
		{
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function deactivate():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			image1_1.y += speed1;
			image1_2.y += speed1;
			
			image2_1.y += speed2;
			image2_2.y += speed2;
			
			for each( var im:Image in images)
			{
				if (im.y > stage.stageHeight)
					im.y = - stage.stageHeight;
			}
		}
		
	}

}