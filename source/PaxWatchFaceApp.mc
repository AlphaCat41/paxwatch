import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class PaxWatchFaceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Triggered when user modifies settings via Garmin Connect or Simulator
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate(); // Forces the watch face to redraw with new settings
    }

    function getInitialView() as [WatchUi.Views] or [WatchUi.Views, WatchUi.InputDelegates] {
        return [ new PaxWatchFaceView() ];
    }

}

function getApp() as PaxWatchFaceApp {
    return Application.getApp() as PaxWatchFaceApp;
}