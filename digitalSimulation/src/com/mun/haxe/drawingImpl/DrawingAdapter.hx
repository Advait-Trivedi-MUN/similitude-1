package com.mun.haxe.drawingImpl;

import com.mun.haxe.drawingInterface.DrawingAdapterI;
import com.mun.haxe.drawingInterface.WorldToViewI;
import com.mun.haxe.enumeration.Orientation;
import js.html.CanvasRenderingContext2D;

/** This class used for drawing the base components
*
*  @author Hui Wan
**/
class DrawingAdapter implements DrawingAdapterI {

    var cxt:CanvasRenderingContext2D;
    var worldToView:WorldToViewI;
    var trokeColor:String = "black";//default line color is black
    var fillColor:String = "gray";//default fill color is gray
    var textColor:String = "black";//default text color is black
    var lineWidth:Float = 1.0;//because the defalut line width is 1.0
    var font:String = "15px serif";//initial is 15


    public function new(cxt:CanvasRenderingContext2D) {
        this.cxt = cxt;
        worldToView = new WorldToView(1);
    }

    public function setStrokeColor(color:String):Void {
        trokeColor = color;
    }

    public function setFillColor(color:String):Void {
        fillColor = color;
    }

    public function setTextColor(color:String):Void {
        textColor = color;
    }

    public function setTextFont(font:String):Void{
        this.font = font;
    }

    public function setLineWidth(width:Float):Void {
        cxt.lineWidth = width;
    }

    public function drawAndShape(x:Float, y:Float, width:Float, height:Float, orientation:Orientation):Void {
        var r:Box = new Box(x, y, width, height, orientation, worldToView);
        // Make a rectangle from a to (a+b)/2 to (c+d)/2 to d and back to a.
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());
        cxt.lineTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2);
        cxt.lineTo((r.get_xc() + r.get_xd()) / 2, (r.get_yc() + r.get_yd()) / 2);
        cxt.lineTo(r.get_xd(), r.get_yd());

        cxt.closePath();

        var cxmin:Float = Math.min(Math.min(r.get_xa(), r.get_xb()), Math.min(r.get_xc(), r.get_xd()));
        var cymin:Float = Math.min(Math.min(r.get_ya(), r.get_yb()), Math.min(r.get_yc(), r.get_yd()));

        var cxmax:Float = Math.max(Math.max(r.get_xa(), r.get_xb()), Math.max(r.get_xc(), r.get_xd()));
        var cymax:Float = Math.max(Math.max(r.get_ya(), r.get_yb()), Math.max(r.get_yc(), r.get_yd()));
        //creat a circle for the AND gate
        //draw the ellipse
        switch (orientation){
            case Orientation.NORTH : {
                cxt.ellipse(x, y, (cxmax - cxmin) / 2, (cymax - cymin) / 1.5, 180 * Math.PI / 180, 0, 1 * Math.PI);}
            case Orientation.EAST : {
                cxt.ellipse(x, y, (cxmax - cxmin) / 2, (cymax - cymin) / 1.5, 270 * Math.PI / 180, 0, 1 * Math.PI);}
            case Orientation.SOUTH : {
                cxt.ellipse(x, y, (cxmax - cxmin) / 2, (cymax - cymin) / 1.5, 0 * Math.PI / 180, 0, 1 * Math.PI);}
            case Orientation.WEST : {
                cxt.ellipse(x, y, (cxmax - cxmin) / 2, (cymax - cymin) / 1.5, 90 * Math.PI / 180, 0, 1 * Math.PI);}
            default : {
                //noting. Orientation only have four values
            }
        }
        cxt.closePath();
        cxt.fillStyle = fillColor;
        setFillColor("gray");
        cxt.fill();
    }

    public function drawOrShape(x:Float, y:Float, width:Float, height:Float, orientation:Orientation):Void {
        var r:Box = new Box(x, y, width, height, orientation, worldToView);
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());

        // Curve to point (b+c)/2   --- Control point is between a and b
        cxt.quadraticCurveTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2, (r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2);
        // Curve to point d  --- Control point is between c and d
        cxt.quadraticCurveTo((r.get_xc() + r.get_xd()) / 2, (r.get_yc() + r.get_yd()) / 2, r.get_xd(), r.get_yd()) ;
        // Curve to point a
        cxt.quadraticCurveTo(0.25 * (r.get_xa() + r.get_xb() + r.get_xc() + r.get_xd()), 0.25 * (r.get_ya() + r.get_yb() + r.get_yc() + r.get_yd()), r.get_xa(), r.get_ya()) ;

        cxt.closePath();
        cxt.fillStyle = fillColor;
        cxt.fill();
    }

    public function drawBufferShape(x:Float, y:Float, width:Float, height:Float, orientation:Orientation):Void {
        var r:Box = new Box(x, y, width, height, orientation, worldToView);
        cxt.beginPath();
        // Start at point a
        cxt.moveTo(r.get_xa(), r.get_ya());
        // Line to point (b+c)/2
        cxt.lineTo((r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2) ;
        // Line to d
        cxt.lineTo(r.get_xd(), r.get_yd()) ;
        // Back to a
        cxt.fillStyle = fillColor;
        cxt.closePath();
        cxt.fill();

    }

    public function drawNotShape(x:Float, y:Float, width:Float, height:Float, orientation:Orientation):Void {
        var r:Box = new Box(x, y, width, height, orientation, worldToView);
        // Start at point a
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());
        // Line to point (b+c)/2
        cxt.lineTo((r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2) ;
        // Line to d
        cxt.lineTo(r.get_xd(), r.get_yd()) ;
        // Back to a
        cxt.closePath();

        var circleCentreX:Float = (r.get_xb() + r.get_xc()) / 2 ;
        var circleCentreY:Float = (r.get_yb() + r.get_yc()) / 2 ;
        var radius:Float = Math.sqrt((r.get_xb() - r.get_xc()) * (r.get_xb() - r.get_xc()) + (r.get_yb() - r.get_yc()) * (r.get_yb() - r.get_yc())) / 10 ;
        trace("radius = " + radius + " x = " + circleCentreX + " y = " + circleCentreY);

        //draw the circle
        switch (orientation){
            case Orientation.NORTH : {
                cxt.arc(circleCentreX, circleCentreY + radius / 2, radius, 0, 2 * Math.PI, false); }
            case Orientation.EAST : {
                cxt.arc(circleCentreX - radius / 2, circleCentreY, radius, 0, 2 * Math.PI, false); }
            case Orientation.SOUTH : {
                cxt.arc(circleCentreX, circleCentreY - radius / 2, radius, 0, 2 * Math.PI, false); }
            case Orientation.WEST : {
                cxt.arc(circleCentreX + radius / 2, circleCentreY, radius, 0, 2 * Math.PI, false); }
            default : {
                //noting. Orientation only have four values
            }
        }
        cxt.fillStyle = fillColor;
        cxt.fill();
    }

    public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
        var x0 : Float = worldToView.convertX(x - width/2);
        var y0 : Float = worldToView.convertY(y - height/2);
        var x1 : Float = worldToView.convertX(x + width/2);
        var y1 : Float = worldToView.convertY(y + height/2);
        cxt.beginPath();
        cxt.fillRect(Math.min(x0,x1), Math.min(y0,y1),Math.abs(x1-x0),Math.abs(y1-y0));
        cxt.closePath();
        cxt.fillStyle = fillColor;
        cxt.fill();

    }

    public function drawText(str:String, x:Float, y:Float, width:Float):Void {
        cxt.font = font;
        cxt.fillStyle = textColor;
        cxt.fillText(str,x,y,width);
    }

    public function drawCricle(x:Float, y:Float, radius:Float):Void {
        var x0 : Float = worldToView.convertX(x - radius);
        var y0 : Float = worldToView.convertY(y - radius);
        var x1 : Float = worldToView.convertX(x + radius);
        var y1 : Float = worldToView.convertY(y + radius);
        cxt.beginPath();
        cxt.arc(Math.min(x0,x1), Math.min(y0,y1),radius,0,2*Math.PI,false);
        cxt.closePath;
        cxt.fillStyle = fillColor;
        cxt.fill();
    }

    public function drawLine(vx0:Float, vy0:Float, vx1:Float, vy1:Float):Void {
        var x0 : Float = worldToView.convertX(vx0);
        var y0 : Float = worldToView.convertY(vy0);
        var x1 : Float = worldToView.convertX(vx1);
        var y1 : Float = worldToView.convertY(vy1);
        trace(x0 + "  " + y0 + "  " + x1 + "  " + y1);
        cxt.beginPath();
        cxt.moveTo(x0,y0);
        cxt.lineTo(x1,y1);
        cxt.closePath();
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.fill();
    }
}