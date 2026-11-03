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
}