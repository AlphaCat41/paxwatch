import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;

module DateClockUtils {

    // Returns a formatted time string (e.g., "08:45" or "20:45")
    function getFormattedTime() as String {
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        // Read user preference from settings (defaults to true if null)
        var is24Hour = Application.Properties.getValue("Use24Hour");
        
        // Respect system 12-hour / 24-hour setting
        if (!is24Hour) {
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

        var dateFormat = Application.Properties.getValue("DateFormat");
        
        var dateString = "";
        switch (dateFormat) {
            case 0: // Layout 0: Day_Week Day Month (TUE 3 NOV)
                dateString = Lang.format("$1$ $2$ $3$", [dateInfo.day_of_week, dateInfo.day, dateInfo.month]);
                break;
            case 1: // Layout 1: Day Month (3 NOV)
                dateString = Lang.format("$1$ $2$", [dateInfo.day, dateInfo.month]);
                break;
            default:
                dateString = Lang.format("$1$ $2$ $3$ $4$", [
                    dateInfo.day_of_week,
                    dateInfo.day,
                    dateInfo.month,
                    dateInfo.year
                ]);
                break;
        }
        
        // Convert the entire string to uppercase
        return dateString.toUpper();
    }

   function drawDateClock(
        dc as Graphics.Dc,
        ox as Numeric,
        oy as Numeric
    ) as Void {
        var formatted_time_Str = getFormattedTime();
        var time_font_size = Graphics.FONT_NUMBER_MILD;

        var formatted_date_Str = getFormattedDate();
        var date_font_size = Graphics.FONT_TINY;

        // Draw the time
        Draw.drawText(
            dc,
            ox,
            oy,
            time_font_size,
            Graphics.COLOR_WHITE,
            Graphics.COLOR_TRANSPARENT,
            getFormattedTime()
        );
        var time_dimensions = dc.getTextDimensions(formatted_time_Str, time_font_size);
        var timeWidth = time_dimensions[0];   // Width in pixels
        var timeHeight = time_dimensions[1];  // Height in pixels

        var date_dimensions = dc.getTextDimensions(formatted_date_Str, date_font_size);
        var dateWidth = date_dimensions[0];   // Width in pixels
        // var dateHeight = date_dimensions[1];  // Height in pixels

        // Draw the date (Using FONT_MEDIUM for broad device compatibility)
        Draw.drawText(
            dc,
            ox + (timeWidth / 2) - (dateWidth / 2),
            oy - (timeHeight / 2),
            date_font_size, 
            Graphics.COLOR_LT_GRAY,
            Graphics.COLOR_TRANSPARENT,
            getFormattedDate()
        );
    }
}