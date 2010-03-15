package {
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author godstroke
	 */
	public class Main extends MovieClip {
		
		private var resized:NativeSignal;
		private var trololo:video_clip
		private var originalPerc : Number;
		private var originalWidth : int;
		private var originalHeight : int;
		private var background : background_clip;

		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			originalWidth = 320;
			originalHeight = 240;			originalPerc = originalWidth/originalHeight;
			
			trololo = new video_clip();
			background = new background_clip();
			background.cacheAsBitmap = true;
			
			var n_fr:Number = trololo.totalFrames;
			var r_fr:Number = Math.round(Math.random()*n_fr);
			trololo.gotoAndPlay(r_fr);
			
			resized = new NativeSignal(IEventDispatcher(stage), Event.RESIZE,Event);
			resized.add(onResize);
			
			onResize();
			addChild(background);
			addChild(trololo);
		}

		private function onResize(e:Event=null) : void {
			var W:Number = stage.stageWidth;			var H:Number = stage.stageHeight;
			
			background.x = W/2 - background.width/2;
			background.y = H / 2 - background.height/2;
			
			var stagePerc:Number = W/H;
			if(stagePerc < originalPerc){
				trololo.width = W;				trololo.height = W * (1/originalPerc);
//				trace("vert")
				trololo.y =  (H - trololo.height)/2;
				trololo.x = 0;
				
			} else{
				trololo.height = H ;
				trololo.width = H * (originalPerc);
//				trace("horz");
				trololo.x =  (W - trololo.width)/2;
				trololo.y = 0;
			}
			
			//trololo.play();
		}
	}
}
