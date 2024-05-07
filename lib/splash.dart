import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:workout/glitchtext.dart';
import 'package:workout/main.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:workout/plansmodel/plansmodelclass.dart';
import 'loginsignup.dart';
import 'intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //////// weeklyprogressf
  final profilebox = Hive.box('profile');
  void weeklyprogressf() {
    final now = DateTime.now();
    late dynamic totalwklengt;

    final activityBoxg = Hive.box('actibox');
    if (activityBoxg.get('key') != null) {
      final activityBox = activityBoxg.get('key');
      final sixDaysAgo = now.subtract(const Duration(days: 6));
      final formattedDate = DateFormat.yMd().format(sixDaysAgo);
      final formattedDateTime = DateFormat.yMd().parse(formattedDate);
      final filteredData = activityBox!
          .where((data) =>
              data['date'] != null &&
              DateFormat.yMd().parse(data['date']).isAfter(formattedDateTime))
          .toList();
      List<Map<dynamic, dynamic>> dataList = [];
      for (var item in filteredData) {
        if (item is Map<dynamic, dynamic>) {
          dataList.add(item);
        }
      }

      totalwklengt = dataList.length;
    } else {
      totalwklengt = 10;
    }
    profilebox.put('vweeklyprogress', totalwklengt);
  }

  hiveboxcheck() async {
    if (!Hive.isBoxOpen('profile')) {
      await Hive.openBox('profile');
    }
    if (!Hive.isBoxOpen('actibox')) {
      await Hive.openBox('actibox');
    }
    if (!Hive.isBoxOpen('activitybox')) {
      await Hive.openBox('activitybox');
    }
    if (!Hive.isBoxOpen('plansbox')) {
      await Hive.openBox<Plansmodelclass>('plansbox');
    }
    if (!Hive.isBoxOpen('chartbox')) {
      await Hive.openBox<WeightchartData>('chartbox');
    }
    //// check adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PlansmodelclassAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(WeightchartDataAdapter());
    }
  }

  checkifstorageboxemptyf() {
    if (Hive.box('profile').get('restval') == null) {
      Hive.box('profile').put('restval', 10);
    }
    if (Hive.box('profile').get('durationbox') == null) {
      Hive.box('profile').put('durationbox', 10);
    }
    if (Hive.box('profile').get('usernamekey') == null) {
      Hive.box('profile').put('usernamekey', 'Demo Name');
    }
    if (Hive.box('profile').get('useremailkey') == null) {
      Hive.box('profile').put('useremailkey', 'Please Logout and Login');
    }
  }

  morningf() async {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    if (currentTime.hour < 12) {
      await Hive.box('profile').put('morningevening', 'Good Morning');
    } else if (currentTime.hour < 18) {
      await Hive.box('profile').put('morningevening', 'Good Afternoon');
    } else {
      await Hive.box('profile').put('morningevening', 'Good Evening');
    }
  }

  @override
  void initState() {
    super.initState();
    hiveboxcheck();
    weeklyprogressf();
    morningf();
    checkifstorageboxemptyf();
    // caluitopbottomnva();
    showNotification();
    openpage();
  }

  ///////////////////////////// call notifications
  void showNotification() async {
    ///// data fetch from server
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .limit(1)
        .get();
    bool whyshow = snapshot.docs.first['show'];
    String title = snapshot.docs.first['title'];
    String body = snapshot.docs.first['desc'];
    if (whyshow) {
      AndroidNotificationDetails androidDetails =
          const AndroidNotificationDetails(
        "channel_id", "Channel_name",
        priority: Priority.max,
        importance: Importance.max,
        // icon: 'bellicon',
        // largeIcon: DrawableResourceAndroidBitmap('bellicon')
      );
      NotificationDetails notiDetails = NotificationDetails(
        android: androidDetails,
      );
      Timer(const Duration(seconds: 20), () {
        notificationsPlugin.show(0, title, body, notiDetails);
      });
    }
  }

  openpage() {
    final checkprofilebox = Hive.box<dynamic>('profile');
    final checkintro = checkprofilebox.get('setintro') ?? '0';
    final checklogin = checkprofilebox.get('usernamekey') ?? '0';
    Timer(const Duration(seconds: 2), () {
      try {
        if (checkintro == '0') {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 3),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const OnBoardingPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        } else if (checklogin == '0') {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 3),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Login(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 3),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Home(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        }
      } catch (e) {
        debugPrint('${e.toString()}----------try catch errors---------');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(' '),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(206, 241, 239, 238),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.deepOrange,
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.deepOrange,
                  Colors.deepOrange.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width * 0.26 / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Workout',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
