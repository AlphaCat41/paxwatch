import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;

module DateClockUtils {

    // Returns a formatted time string (e.g., "08:45" or "20:45")
    function getFormattedTime() as String {
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        // Respect system 12-hour / 24-hour setting
        if (!System.getDeviceSettings().is24Hour) {
            hours = hours % 12;
            if (hours == 0) {
                hours = 12;
            }
        }

        return Lang.format("$1$:$2$", [
            hours.format("%02d"),
            clockTime.min.format("%02d")
        ]);
    }

    // Returns a formatted date string (e.g., "Tue, 3 Nov")
    function getFormattedDate() as String {
        var now = Time.now();
        var dateInfo = Gregorian.info(now, Time.FORMAT_MEDIUM);

        var dateString = Lang.format("$1$ $2$ $3$", [
            dateInfo.day_of_week,
            dateInfo.day,
            dateInfo.month,
        ]);

        // Convert the entire string to uppercase
        return dateString.toUpper();
    }

   function drawDateClock(
        dc as Graphics.Dc,
        ox as Numeric,
        oy as Numeric
    ) as Void {
        
        // Draw the time
        Draw.drawText(
            dc,
            ox,
            oy - 25,
            Graphics.FONT_NUMBER_MILD,
            Graphics.COLOR_WHITE,
            Graphics.COLOR_TRANSPARENT,
            getFormattedTime()
        );

        // Draw the date (Using FONT_MEDIUM for broad device compatibility)
        Draw.drawText(
            dc,
            ox,
            oy + 35,
            Graphics.FONT_TINY, 
            Graphics.COLOR_LT_GRAY,
            Graphics.COLOR_TRANSPARENT,
            getFormattedDate()
        );
    }
}