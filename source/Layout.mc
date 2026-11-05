import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;

module Layout {
    function drawSelectionArc() {

    }
    function Top(
        dc as Graphics.Dc,
        width as Numeric,
        height as Numeric
    ) as Void {
        var mainX = width / 2;
        var mainY = height / 4;
        DateClockUtils.drawDateClock(dc, mainX, mainY);
        
        // var radius = 30;
        // var dataX = mainX - (DateClockUtils.getWidth() / 2) - (radius / 2);
        // var dataY = mainY;
        // DataUtils.DrawBatteryPercentage(dc, dataX, dataY, radius);
    }
    function Middle(
        dc as Graphics.Dc,
        width as Numeric,
        height as Numeric
    ) as Void {
        var mainX = width / 2;
        var mainY = height / 2;
        
        var radius = 30;
        var item1_X = mainX + (DateClockUtils.getWidth() / 2) - (radius / 2);
        var item1_Y = mainY - radius;
        DataUtils.DrawBatteryPercentage(dc, item1_X, item1_Y, radius);

        var item2_Y = item1_Y + (2 * radius);
        DataUtils.DrawStressScore(dc, item1_X, item2_Y, radius);
        
        var item3_Y = item2_Y + (2 * radius);
        DataUtils.DrawBodyBattery(dc, item1_X, item3_Y, radius);
    }
}