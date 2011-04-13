package
{
  import flash.display.MovieClip;
  
  import com.codeazur.as3swf.SWF;
  import com.codeazur.as3swf.tags.TagDefineShape;
  import com.codeazur.as3swf.exporters.CoreGraphicsShapeExporter;

  public class ShapeExportLogo_ObjectiveC extends MovieClip
  {
    public function ShapeExportLogo_ObjectiveC()
    {
      var swf:SWF = new SWF(loaderInfo.bytes);

      // Get the one and only shape
      var tag:TagDefineShape = swf.getCharacter(1) as TagDefineShape;

      // Export the shape to Drawing API code
      var doc:CoreGraphicsShapeExporter = new CoreGraphicsShapeExporter(swf, "Test");
      tag.export(doc);

      trace(doc.h);
      trace("---------------------\n");
      trace(doc.m);
    }
  }
}
