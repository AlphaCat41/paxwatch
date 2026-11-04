import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;

module Layout {
    function main(
        dc as Graphics.Dc,
        width as Numeric,
        height as Numeric
    ) as Void {
        var mainX = width / 2;
        var mainY = height / 4;
        DateClockUtils.drawDateClock(dc, mainX, mainY);
        
        var radius = 30;
        var dataX = mainX - (DateClockUtils.getWidth() / 2) - (radius / 2);
        var dataY = mainY;
        DataUtils.DrawBatteryPercentage(dc, dataX, dataY, radius);
    }
}