import Toybox.System;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Graphics;
import Toybox.Application;

module DateClockUtils {
    // Returns a formatted time string (e.g., "08:45" or "20:45")
    var ampm = "";
    var is24Hour = null;
    var total_width = 0;
    var total_height = 0;

    function getFormattedTime() as String {
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        // Read user preference from settings (defaults to true if null)
        is24Hour = Application.Properties.getValue("Use24Hour");
        
        // Respect system 12-hour / 24-hour setting
        if (!is24Hour) {
            ampm = (hours >= 12) ? "PM" : "AM";
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
    function getSecTime() as String {
        var clockTime = System.getClockTime();
      
        return Lang.format("$1$", [
            clockTime.sec.format("%02d")
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
        var date_font_size = Graphics.FONT_XTINY;

        var sec_Str = getSecTime();
        var sec_font_size = Graphics.FONT_XTINY;

        var clockColor = Application.Properties.getValue("ClockColor");
     
        // Draw the time
        Draw.drawText(
            dc,
            ox,
            oy,
            time_font_size,
            clockColor,
            Graphics.COLOR_TRANSPARENT,
            getFormattedTime()
        );
        var time_dimensions = dc.getTextDimensions(formatted_time_Str, time_font_size);
        var timeWidth = time_dimensions[0];   // Width in pixels
        var timeHeight = time_dimensions[1];  // Height in pixels

        var date_dimensions = dc.getTextDimensions(formatted_date_Str, date_font_size);
        var dateWidth = date_dimensions[0];   // Width in pixels
        var dateHeight = date_dimensions[1];  // Height in pixels

        var dateColor = Application.Properties.getValue("DateColor");
        // Draw the date (Using FONT_MEDIUM for broad device compatibility)
        Draw.drawText(
            dc,
            ox + (timeWidth / 2) - (dateWidth / 2),
            oy - (timeHeight / 2),
            date_font_size, 
            dateColor,
            Graphics.COLOR_TRANSPARENT,
            getFormattedDate()
        );

        var sec_dimensions = dc.getTextDimensions(sec_Str, sec_font_size);
        var secWidth = sec_dimensions[0];   // Width in pixels
        var secHeight = sec_dimensions[1];  // Height in pixels
        
        Draw.drawText(
            dc,
            ox + (timeWidth / 2) + (secWidth / 2),
            oy + (secHeight / 2),
            Graphics.FONT_XTINY, 
            Graphics.COLOR_WHITE,
            Graphics.COLOR_TRANSPARENT,
            getSecTime()
        );

        var ampm_dimensions = dc.getTextDimensions(ampm, sec_font_size);
        var ampmWidth = ampm_dimensions[0];   // Width in pixels
        var ampmHeight = ampm_dimensions[1];  // Height in pixels

        // draw am/pm
        if (!is24Hour) {
            var x = ox + (timeWidth / 2) + (ampmWidth / 2);
            var y = oy - (ampmHeight / 2);

            var boxX = x - (ampmWidth / 2);
            var boxY = y - (ampmHeight / 2);
            
            Draw.drawSquare(dc, boxX, boxY, ampmWidth, ampmHeight);
            Draw.drawText(
                dc,
                x,
                y,
                Graphics.FONT_XTINY, 
                Graphics.COLOR_BLACK,
                Graphics.COLOR_TRANSPARENT,
                ampm
            );
        }

        total_width = timeWidth + (ampmWidth > secWidth? ampmWidth : secWidth);
        total_height = timeHeight + dateHeight;
    }

    function getWidth() as Number {
        return total_width;
    }

     function getHeight() as Number {
        return total_height;
    }
}