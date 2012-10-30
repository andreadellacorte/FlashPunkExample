package
{
    import net.flashpunk.FP;
	import net.flashpunk.World;
	public class TheWorld extends World
	{
		public function TheWorld()
		{
            trace("TheWorld created!");
		}
        
        override public function begin( ):void
        {
            FP.screen.color = 0
            
            add( new Player );
			add( new Wall( this ) );
        }
        
        override public function update( ):void
        {
            super.update( );
        }
	}
}