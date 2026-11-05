import Toybox.Graphics;
import Toybox.Lang;

module Draw {
    // Add explicit types for all parameters and use Graphics.Dc
  function drawText(
        dc as Graphics.Dc,
        x as Numeric,
        y as Numeric,
        font as Graphics.FontType,
        color as Number,
        background as Number,
        text as String
    ) as Void {
        dc.setColor(color, background);
        dc.drawText(
            x,
            y,
            font,
            text,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
    function drawGauge(
        dc as Graphics.Dc,
        centerX as Numeric,
        centerY as Numeric,
        radius as Numeric,
        data as String,
        lowerData as Numeric,
        lowerDataColor as Numeric
    ) as Void {
        
        // 1. Draw Background Track (Full or partial gray circle)
        dc.setPenWidth(6); // Thickness of the gauge ring
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(
            centerX,
            centerY,
            radius,
            Graphics.ARC_CLOCKWISE,
            225,
            -45
        );

        // 2. Calculate Sweep Angle based on Battery Percentage (0 - 100%)
        // Map 0-100% to 0-360 degrees (or a partial arc if you prefer)
        var sweepAngle = (data.toNumber() / 100.0) * 270.0;
        
        // Choose color based on level (e.g., Red if low, White/Green if normal)
        var gaugeColor = Graphics.COLOR_BLUE;
        if (data.toNumber() <= lowerData) {
            gaugeColor = lowerDataColor;
        }

        // 3. Draw Active Progress Arc
        // Start angle at 90 (top / 12 o'clock) going clockwise
        dc.setPenWidth(6);
        dc.setColor(gaugeColor, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(
            centerX,
            centerY,
            radius,
            Graphics.ARC_CLOCKWISE,
            225,
            225 - sweepAngle
        );

        // 4. Draw Percentage Text Inside the Circle
        var textString = data + "%";
        dc.drawText(
            centerX,
            centerY,
            Graphics.FONT_XTINY,
            textString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    function drawSquare( dc as Graphics.Dc, x as Numeric, y as Numeric, sizeX as Numeric, sizeY as Numeric) {
        // 1. Set the drawing color to white (and background to transparent)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // 3. Draw the filled square
        dc.fillRectangle(x, y, sizeX, sizeY);
    }
}