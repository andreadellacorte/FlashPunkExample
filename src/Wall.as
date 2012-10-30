package  
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    
	/**
     * ...
     * @author ValiumKnight
     */
    public class Wall extends Entity
    {
        public function Wall( theWorld:World ) 
        {
            x = FP.width / 2;
            y = ( FP.height / 2 ) + 100;
            
            theWorld.add( new Block( ) );
            
            setHitbox( 100, 10, 0, -70 );
            
            layer = -1;
            
            type = "solid";
        }
    }
}