package  
{
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.geom.Matrix;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Rob Filippi
	 */
	public class Block extends Entity 
	{
		[Embed(source = 'assets/blu_block.png')] private const RBLOCK:Class;
        
        private var blockImage:Image;
        private var solidMask:BitmapData;
        private var transparentMask:BitmapData
		
		public function Block( ) 
		{
			blockImage = new Image( RBLOCK );
            
			x = FP.width / 2;
            y = ( FP.height / 2 ) + 100;
			
			setHitbox( 100, 80 );
			
			type = "wall";
            
            graphic = blockImage;
            
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox( blockImage.width, blockImage.height, Math.PI / 2 );

            var gradient:Shape = new Shape();
            
            gradient.graphics.beginGradientFill( 'linear', [0xFFFFFF, 0xFFFFFF], [0.3, 1],[0, 255], matrix );
            gradient.graphics.drawRect(0, 0, blockImage.width, blockImage.height);
            gradient.graphics.endFill();
            gradient.cacheAsBitmap = true;
            
            transparentMask = new BitmapData( gradient.width, gradient.height, true, 0 );
            transparentMask.draw( gradient );
            
            gradient.graphics.beginGradientFill( 'linear', [0xFFFFFF, 0xFFFFFF], [1,1],[255,255], matrix );
            gradient.graphics.drawRect(0, 0, blockImage.width, blockImage.height);
            gradient.graphics.endFill();
            gradient.cacheAsBitmap = true;
            
            solidMask= new BitmapData( gradient.width, gradient.height, true, 0 );
            solidMask.draw( gradient );
		}
        
        override public function update( ):void
        {
			if ( collide( "player", x-2, y-2 ) )
			{
                layer = -1;
                blockImage.drawMask = transparentMask;
            }
            else
            {
                layer = 1;
                blockImage.drawMask = solidMask;
            }
        }
	}

}