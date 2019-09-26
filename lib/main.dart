import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:langfella2/pages/main_page_bottom_nav.dart';
import 'pages/main_page_bottom_nav.dart';


/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');

//  SharedPreferences prefs = await SharedPreferences.getInstance();
//
//  // Read fetch_events from SharedPreferences
//  List<String> events = [];
//  String json = prefs.getString(EVENTS_KEY);
//  if (json != null) {
//    events = jsonDecode(json).cast<String>();
//  }
//  // Add new event.
//  events.insert(0, new DateTime.now().toString() + ' [Headless]');
//  // Persist fetch events in SharedPreferences
//  prefs.setString(EVENTS_KEY, jsonEncode(events));

  BackgroundFetch.finish();
}

void main() {
  runApp(Langfella());

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class Langfella extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        title: 'Book List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            padding: EdgeInsets.all(12),
          ),
          textTheme: TextTheme(title: TextStyle(
              fontSize: 18
          )),
        ),
        home: BottomNavigation(),
      );


  final bool _enabled = true;
  final int _status = 0;
  final List<String> _events = [];


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Load persisted fetch events from SharedPreferences
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String json = prefs.getString(EVENTS_KEY);
//    if (json != null) {
//      setState(() {
//        _events = jsonDecode(json).cast<String>();
//      });
//    }

    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_NONE
    ), _onBackgroundFetch).then((int status) {
      print('[BackgroundFetch] configure success: $status');
//      setState(() {_status = status;});
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
//      setState(() {_status = e;});
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
//    setState(() {_status = status;});

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
//    if (!mounted) return;
  }

  void _onBackgroundFetch() async {

    //TODO  fetch event here = query the database for words and show notification
    print('query run to fetch the words to revise');



//    SharedPreferences prefs = await SharedPreferences.getInstance();

    // This is the fetch-event callback.
    print('[BackgroundFetch] Event received');
//    setState(() { _events.insert(0, new DateTime.now().toString());});
    // Persist fetch events in SharedPreferences
//    prefs.setString(EVENTS_KEY, jsonEncode(_events));

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish();
  }

}

