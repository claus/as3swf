package
{
  import flash.display.Loader;
  import flash.display.MovieClip;
  import flash.display.Stage;
  
  import com.codeazur.as3swf.SWF;
  import com.codeazur.as3swf.SWFData;
  import com.codeazur.as3swf.data.SWFFillStyle;
  import com.codeazur.as3swf.data.SWFLineStyle;
  import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;
  import com.codeazur.as3swf.tags.TagDefineShape;

  public class PublishModifiedLogo extends MovieClip
  {
    public function PublishModifiedLogo()
    {
      if(parent is Stage)
      {
        var swf:SWF = new SWF(root.loaderInfo.bytes);

        // Get the one and only shape
        var tag:TagDefineShape = swf.getCharacter(1) as TagDefineShape;

        // Change fill styles
        tag.shapes.initialFillStyles[0].rgb = 0xffcccccc;
        tag.shapes.initialFillStyles[1].rgb = 0xffcccccc;

        // Add a line style
        var lineStyle:SWFLineStyle = new SWFLineStyle();
        lineStyle.color = 0xffff0000;
        lineStyle.width = 40;
        tag.shapes.initialLineStyles.push(lineStyle);

        // Tell the shape to use that line style
        var record:SWFShapeRecordStyleChange = tag.shapes.records[0] as SWFShapeRecordStyleChange;
        record.stateLineStyle = true;
        record.lineStyle = 1;

        var ba:SWFData = new SWFData();
        swf.publish(ba);

        var loader:Loader = new Loader();
        loader.loadBytes(ba);
        loader.x = 200;
        addChild(loader);
      }
    }
  }
}
