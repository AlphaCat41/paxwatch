import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;

module DataUtils {
    function getBatteryPercentage() as Numeric {
        var stats = System.getSystemStats();
        if (stats != null && stats.battery != null) {
            return stats.battery.toNumber();
        }
        return 100; // Fallback default
    }

    function DrawBatteryPercentage(
        dc as Graphics.Dc,   
        ox as Numeric,
        oy as Numeric,
        radius as Numeric
    ) as Void {
        Draw.drawGauge(dc, ox, oy, radius, getBatteryPercentage());
    }
}