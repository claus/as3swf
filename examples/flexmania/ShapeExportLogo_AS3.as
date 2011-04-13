package
{
  import flash.display.MovieClip;
  
  import com.codeazur.as3swf.SWF;
  import com.codeazur.as3swf.tags.TagDefineShape;
  import com.codeazur.as3swf.exporters.AS3ShapeExporter;

  public class ShapeExportLogo_AS3 extends MovieClip
  {
    public function ShapeExportLogo_AS3()
    {
      var swf:SWF = new SWF(loaderInfo.bytes);

      // Get the one and only shape
      var tag:TagDefineShape = swf.getCharacter(1) as TagDefineShape;

      // Export the shape to Drawing API code
      var doc:AS3ShapeExporter = new AS3ShapeExporter(swf);
      tag.export(doc);

      trace(doc.actionScript);
    }
  }
}
