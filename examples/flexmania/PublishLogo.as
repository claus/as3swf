package
{
  import flash.display.Loader;
  import flash.display.MovieClip;
  import flash.display.Stage;
  
  import com.codeazur.as3swf.SWF;
  import com.codeazur.as3swf.SWFData;

  public class PublishLogo extends MovieClip
  {
    public function PublishLogo()
    {
      if(parent is Stage)
      {
        // loaderInfo.bytes is a ByteArray containing the raw, 
        // uncompressed SWF of the document class instance.
        // Parse the SWF this code is running in:
        var swf:SWF = new SWF(loaderInfo.bytes);
        
        // SWFData is a subclassed ByteArray
        // (implements read/write methods for SWF specific datatypes)
        var ba:SWFData = new SWFData();
        
        // Publish the parsed SWF back to a ByteArray:
        swf.publish(ba);
        
        // Load the published SWF and add it to the display list:
        var loader:Loader = new Loader();
        loader.x = 200;
        loader.loadBytes(ba);
        addChild(loader);
      }
    }
  }
}
