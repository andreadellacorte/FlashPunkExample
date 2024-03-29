package
{
    import flash.geom.Point;
    import net.flashpunk.FP;
	import net.flashpunk.Entity;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
    import net.flashpunk.graphics.Spritemap;
    import com.matttuttle.PhysicsEntity;

	public class Player extends PhysicsEntity
	{
		[Embed(source = 'assets/swordguy.png')] private const SWORDGUY:Class;
        
        private const _sprite:Spritemap = new Spritemap( SWORDGUY, 48, 32 );
        private const _moveSpeed:uint = 1;
		private const _jumpForce:uint = 1;
        private const _floorFriction:Number = 0.5;
        private const _wallFriction:Number = 0.8;
        private const _weight:Number = 0;

        public var debug:Boolean = false;

		public function Player( )
		{
            super( );
            
            x = FP.width / 2;
            y = FP.height / 2;
            
            _sprite.add( "stand", [0, 1, 2, 3, 4, 5], 10, true );
			_sprite.add( "run", [6, 7, 8, 9, 10, 11], 20, true );
			
			//Setting hit box for the player
			setHitbox( 48, 32 ); 
            
            gravity.x = _weight;
            gravity.y = _weight;
			maxVelocity.y = _moveSpeed * 2;
			maxVelocity.x = _moveSpeed * 2;
			friction.x = _floorFriction; // floor friction
			friction.y = _wallFriction; // wall friction
            
            graphic = _sprite;
            
            layer = 0;
            
            type = "player";
		}
        
        override public function update( ): void
        {
            super.update( );
            
            var moved:Boolean = false;
            
            if( Input.check( Key.RIGHT ) ) 
            { 
                _sprite.flipped = false;
                acceleration.x = _moveSpeed; 
                moved = true;
            }
			else if( Input.check( Key.LEFT ) ) 
            { 
                _sprite.flipped = true;
                acceleration.x = -_moveSpeed; 
                moved = true;
            }
            
            if( Input.check( Key.DOWN ) ) 
            { 
                acceleration.y = _moveSpeed; 
                moved = true;
            }
			else if( Input.check( Key.UP ) ) 
            { 
                acceleration.y = -_moveSpeed; 
                moved = true;
            }
            
            // Play the run animation if we are moving the character or if the character speed
            // is a certain amount or if the character is in mid air
            if ( moved || ( velocity.x > _moveSpeed * 1.3 ) || !onGround )
            {
                _sprite.play( "run" );
            }
            else
            {	
                _sprite.play( "stand" );
            }
            
			// Check if the player is touching "solid"
			if ( collide( "solid", x+2, y+2 ) )
			{
				// Do fancy stuff because we have a collison!
			}
			
			// Set up debug condition
			if ( Input.pressed( Key.D ) )
			{
				debug = !debug;
			}	
			
			if ( debug )
			{
                FP.console.enable();
                
				// Move are guy back to the center if he goes off screen
				if ( x > FP.width || x < 0 || y > FP.height || y < 0 ) 
				{
					x = FP.width / 2;
					y = FP.height / 2;
					
					acceleration.x = 0;
					acceleration.y = 0;
				}
				
				// Debugging collisions with "solid" go here
				if ( collide( "solid", x+2, y+2 ) )
				{
					FP.log( "Collision!" );
				}
			}
        }
	}
}