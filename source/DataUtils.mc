import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;
using Toybox.ActivityMonitor;

module DataUtils {

    function getBatteryPercentage() as String {
        var stats = System.getSystemStats();
        if (stats != null && stats.battery != null) {
            return stats.battery.format("%d");
        }
        return "--"; // Fallback default
    }

    function getStressScore() as String {
        // Get the latest stress score
        var info = ActivityMonitor.getInfo();
        var stressScore = null;

        if (info has :stressScore && info.stressScore != null) {
            stressScore = info.stressScore; // Returns an integer (1-100)
                return stressScore.format("%d");
        }
        else {
            // Stress is unavailable, measuring, or device is off-wrist
            return "--";
        }
    }

    using Toybox.SensorHistory;

    function getBodyBattery() as String{
        // Check if the device and API support Body Battery history
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getBodyBatteryHistory)) {
            // Fetch the newest sample
            var iterator = SensorHistory.getBodyBatteryHistory({
                :period => 1, 
                :order => SensorHistory.ORDER_NEWEST_FIRST
            });
            
            if (iterator != null) {
                var sample = iterator.next();
                if (sample != null && sample.data != null) {
                    // Returns an integer value from 0 to 100
                    return sample.data.format("%d");
                }
            }
        }
        
        // Return null if unsupported, initializing, or off-wrist
        return "--"; 
    }

    function DrawBatteryPercentage(
        dc as Graphics.Dc,   
        ox as Numeric,
        oy as Numeric,
        radius as Numeric
    ) as Void {
        Draw.drawGauge(dc, ox, oy, radius, getBatteryPercentage(), 20, Graphics.COLOR_RED);
        // Draw.drawGauge(dc, ox, oy, radius, "19", 20, Graphics.COLOR_RED);
    }
    function DrawStressScore(
        dc as Graphics.Dc,   
        ox as Numeric,
        oy as Numeric,
        radius as Numeric
    ) as Void {
        Draw.drawGauge(dc, ox, oy, radius, getStressScore(), 20, Graphics.COLOR_GREEN);
        // Draw.drawGauge(dc, ox, oy, radius, "19", 20, Graphics.COLOR_GREEN);
    }

    function DrawBodyBattery(
        dc as Graphics.Dc,   
        ox as Numeric,
        oy as Numeric,
        radius as Numeric
    ) as Void {
        Draw.drawGauge(dc, ox, oy, radius, getBodyBattery(), 20, Graphics.COLOR_RED);
    }
}