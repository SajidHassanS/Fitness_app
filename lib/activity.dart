import 'dart:math';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:calendar_flutter_aj/calender_flutter.dart';
// import 'package:workout/home.dart';
import 'package:workout/plansmodel/getpplansdata.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'historyexerc.dart';
// import 'home.dart';
import 'plansmodel/plansmodelclass.dart';
// import 'package:calendar_flutter_aj/main.dart';

class BMIControllerclass extends GetxController {
  var weight = 0.0.obs;
  var height = 0.0.obs;
  var bmi = 0.0.obs;

  void calculateBMI() {
    if (weight.value != 0 && height.value != 0) {
      bmi.value = weight.value / ((height.value / 100) * (height.value / 100));
    }
  }
}

class Activitypage extends StatefulWidget {
  const Activitypage({super.key});

  @override
  State<Activitypage> createState() => _ActivitypageState();
}

class _ActivitypageState extends State<Activitypage> {
  final BMIControllerclass bmicall = Get.put(BMIControllerclass());
  // BMIControllerclass bmifind = Get.find<BMIControllerclass>();

  String? todayactivitydate;
  DateTime? calenderSelectedDate = DateTime.now();

  void vactivitywklistf(DateTime date) {
    final formattedDate = DateFormat.yMd().format(date);

    final now = DateTime.now();
    final formatdatnow = DateFormat.yMd().format(now);
    List<Map<String, dynamic>> tempdata = [
      {
        'excertitle': 'Punches',
        'excerimage': 'assets/wk/54.gif',
        'date': formatdatnow,
        'durationstime': 20,
        'calburn': 10,
      },
      {
        'excertitle': 'Jumping Jacks',
        'excerimage': 'assets/wk/33.gif',
        'date': formatdatnow,
        'durationstime': 15,
        'calburn': 5,
      }
    ];
    /////////// start hive box
    final activityBoxg = Hive.box<dynamic>('actibox');
    final activityBox = activityBoxg.get('key') ?? tempdata;

    // ignore: unnecessary_null_comparison

    // Filter the list to include only activities with the desired date
    final filteredData =
        activityBox.where((data) => data['date'] == formattedDate).toList();
    List<Map<dynamic, dynamic>> dataList = [];
    for (var item in filteredData) {
      if (item is Map<dynamic, dynamic>) {
        dataList.add(item);
      }
    }

    // Store data in variable for display
    totalwklength = dataList.length;
    totalcalburns = filteredData.fold(0, (sum, data) => sum + data['calburn']);
    final totdurationsec = filteredData.fold(
      const Duration(),
      (sum, data) => sum + Duration(seconds: data['durationstime']),
    );
    Duration duration = Duration(seconds: totdurationsec.inSeconds);
    vformattedTime = duration.toString().split('.').first.padLeft(8, "0");
    dataForDate = dataList;

    setState(() {});
  }

  List<Map<dynamic, dynamic>> dataForDate = [];
  ///////// its for used to convert seconds to minutes seconds formate

  String? vformattedTime = '00:00:00';
  ///////// its for used to convert seconds to minutes seconds formate
  int? totalwklength = 2;
  num totalcalburns = 15.0;
  ///// for hive box
  // late Box<dynamic> prfilebox;
  ///// for hive box
// //////// weeklyprogressf
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

//////////////////// check internet for ads
  Future showadsf() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('settings')
            .doc('ads') // here is id of user
            .get();
        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          final whyshowads = data?['showads'];
          if (whyshowads) {
            showlocaladsbool2 = true;
            adstitle = data?['adstitle'];
            adsdesc = data?['adsdesc'];
            adsurl = data?['adsurl'];
          }
          setState(() {});
        }
      } catch (e) {
        debugPrint('Error fetching name: $e');
      }
    }
  }

  bool showlocaladsbool2 = false;
  late String adstitle;
  late String adsdesc;
  late String adsurl;
//////////////////// check internet for ads end
  ///weeklyprogressf
  @override
  void initState() {
    showadsf();
    DateTime now = DateTime.now();
    todayactivitydate = DateFormat('EEEE, d MMMM').format(now);
    vactivitywklistf(DateTime.now());
    weeklyprogressf();

    super.initState();
  }

  @override
  void dispose() {
    showadsf();
    super.dispose();
  }

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
  Future<void> _launchInBrowser(String url) async {
    if (!await launcher.launch(
      url,
      useSafariVC: false,
      useWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{},
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Today',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cbold'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 239, 234),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      todayactivitydate.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: 2,
                    child: CircularSeekBar(
                      width: double.infinity,
                      height: 150,
                      progress: totalcalburns <= 10
                          ? 4.0
                          : totalcalburns >= 199
                              ? 99
                              : totalcalburns.toDouble() / 2,
                      barWidth: 12,
                      startAngle: 45,
                      sweepAngle: 350,
                      strokeCap: StrokeCap.round,
                      progressGradientColors: [
                        Colors.red.withOpacity(0.5),
                        Colors.orange.withOpacity(0.5),
                        Colors.yellow.withOpacity(0.5),
                        Colors.green.withOpacity(0.5),
                      ],
                      innerThumbRadius: 0,
                      innerThumbStrokeWidth: 0,
                      innerThumbColor: Colors.white,
                      outerThumbRadius: 0,
                      outerThumbStrokeWidth: 10,
                      outerThumbColor: Colors.blueAccent,
                      animation: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Text('Active Calories'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${totalcalburns / 2}/200',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cbold'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Cal'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 11.0, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 244, 218),
                        borderRadius: BorderRadius.circular(20)),
                    width: Get.size.width * 0.4 / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: Get.size.width * 0.08 / 1,
                              child: Image.asset('assets/images/calories.png')),
                          const SizedBox(height: 8),
                          const Text(
                            'Burn Calories',
                            style: TextStyle(
                                fontFamily: 'csemibold',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${totalcalburns / 2}/200 CAl',
                            style: const TextStyle(
                                fontFamily: 'clight',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: Get.size.width * 1.5 / 4,
                        height: Get.size.height * 0.24 / 4,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 203, 231, 254),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: Get.size.height * 0.16 / 4,
                                child:
                                    Image.asset('assets/images/dumbell_1.png')),
                            Text(
                              '$totalwklength Workout',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'clight'),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: Get.size.width * 1.5 / 4,
                        height: Get.size.height * 0.24 / 4,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 205, 255, 248),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: Get.size.height * 0.16 / 4,
                                child: Image.asset('assets/images/clock1.png')),
                            Text(
                              vformattedTime.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'clight'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            showlocaladsbool2
                ? Dismissible(
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.ads_click)),
                      ],
                    ),
                    secondaryBackground: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.visibility_off,
                              color: Colors.redAccent,
                            )),
                      ],
                    ),
                    onDismissed: (v) {
                      _launchInBrowser(adsurl);
                      setState(() {
                        showlocaladsbool2 = !showlocaladsbool2;
                      });
                    },
                    key: const ValueKey(1),
                    child: InkWell(
                      onTap: () {
                        _launchInBrowser(adsurl);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 232, 235, 236),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text(
                                'Dismissible Ads',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'cmedium',
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 232, 235, 236),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.deepOrange.withOpacity(0.2),
                                        offset: const Offset(0, 10),
                                        blurRadius: 20,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20))),
                              child: ListTile(
                                title: Text(
                                  adsdesc.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'cmedium',
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(adstitle.toString()),
                                trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showlocaladsbool2 = !showlocaladsbool2;
                                      });
                                    },
                                    icon: const Icon(Icons.cancel)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Text(''),
            const ListTile(
              title: Text(
                'BMI Calculator',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'cmedium',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4.0, left: 0, right: 0, bottom: 4),
              child: GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Enter Values',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration:
                              const InputDecoration(labelText: 'Weight (kg)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              bmicall.weight.value = double.parse(value),
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(labelText: 'Height (cm)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              bmicall.height.value = double.parse(value),
                        ),
                        ElevatedButton(
                          child: const Text('Calculate'),
                          onPressed: () {
                            bmicall.calculateBMI();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Stack(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/bmi.png',
                            fit: BoxFit.cover,
                          )),
                      Obx(
                        () => Positioned(
                          top: 55,
                          left: bmicall.weight.value > 30 &&
                                  bmicall.weight.value < 300
                              ? bmicall.weight.value
                              : 200,
                          // min 30 max 300
                          child: SizedBox(
                              width: 10,
                              child: Image.asset(
                                'assets/images/ticker.png',
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 2.3 / 4,
                child: const Checkcahrt()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    )
                  ]),
                  child: CalendarFlutterAj(
                    selectedDate: (selectedDate) {
                      calenderSelectedDate = selectedDate;
                      vactivitywklistf(selectedDate);
                      setState(() {});
                    },
                    backArrow: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromARGB(255, 177, 172, 172)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(31, 163, 151, 151),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: 10, right: 4, bottom: 4.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 156, 149, 149),
                          size: 12,
                        ),
                      ),
                    ),
                    forwardArrow: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromARGB(255, 177, 172, 172)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(31, 163, 151, 151),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 4, left: 5, right: 8, bottom: 4.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Color.fromARGB(255, 156, 149, 149),
                          size: 12,
                        ),
                      ),
                    ),
                    calenderBackgroundColor: Colors.white,
                    selectedDayColor: Colors.deepOrange,
                    selectedDayWidget: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                    calenderSelectedDateBackgroundcolor: Colors.deepOrange,
                    calenderSelectedDateColor: Colors.white,
                    showCalenderSelectedDateBackgroundcolor: true,
                    calenderSelectedDateBorderRadius: BorderRadius.circular(10),
                    calenderSelectedDateFontSize: 17,
                    dayTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    monthBackgroundColor: Colors.white,
                    monthTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    weekdaysTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 180, 176, 176)),
                    yearBackgroundColor: Colors.white,
                    yearTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    calenderUnSelectedDatesColor: Colors.black54,
                    yearPopHeadingText: "year",
                    yearPopHeadingTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    yearsListTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    monthPopHeadingText: "month",
                    monthPopHeadingTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    monthsListTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(const Vallactivity());
              },
              title: const Text(
                'Summary',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              trailing: const Text('see all'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 / 1,
              child: ListView.builder(
                itemCount: dataForDate.length,
                itemBuilder: (context, index) {
                  final item = dataForDate[index];
                  //////// fo date time
                  final date =
                      DateFormat('MM/dd/yyyy').parse(item['date'] as String);
                  todayactivitydate = DateFormat('EEEE, d MMMM').format(date);
                  ///////// for durations methods

                  Duration duration = Duration(seconds: item['durationstime']);
                  var formattedTime =
                      duration.toString().split('.').first.padLeft(8, "0");

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Transform.scale(
                            scale: 1.3,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7.0)),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  height: Get.size.height * 0.4 / 4,
                                  width: Get.size.width * 0.4 / 4,
                                  child: Transform.scale(
                                      scale: 1.1,
                                      child: Image.asset(item['excerimage']))),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['excertitle'].length >= 6
                                      ? item['excertitle']
                                          .split(' ')
                                          .take(2)
                                          .join(' ')
                                      : item['excertitle'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Flexible(
                                  child: Text(
                                    todayactivitydate.toString(),
                                    style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        color: Colors.black,
                                        fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 6),
                            child: Row(children: [
                              Container(
                                width: Get.size.width * 0.8 / 4,
                                height: Get.size.height * 0.12 / 4,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        172, 203, 231, 254),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          height: Get.size.height * 0.10 / 4,
                                          child: Image.asset(
                                              'assets/images/clock1.png')),
                                      Text(
                                        formattedTime.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                            fontFamily: 'clight'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Container(
                                width: Get.size.width * 0.8 / 4,
                                height: Get.size.height * 0.12 / 4,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        178, 254, 222, 203),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          height: Get.size.height * 0.10 / 4,
                                          child: Image.asset(
                                              'assets/images/fire.png')),
                                      Text(
                                        item['calburn'].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                            fontFamily: 'clight'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////

class Checkcahrt extends StatefulWidget {
  const Checkcahrt({Key? key}) : super(key: key);

  @override
  State<Checkcahrt> createState() => _CheckcahrtState();
}

class WeightData {
  final double weight;
  final DateTime date;

  WeightData({required this.weight, required this.date});
}

class _CheckcahrtState extends State<Checkcahrt> {
  TextEditingController weightalertinputcontr = TextEditingController();
  bool todayweightadded = false;
  ///////////////// hive
  final chartbox = Chartbox.data();
  callchartlisthive() {
    List<WeightchartData> chartData = chartbox.values.toList();
    if (chartData.isEmpty) {
      final random = Random();
      final startDate = DateTime.now().subtract(const Duration(days: 30));
      final chartData = List.generate(3, (index) {
        final weight = random.nextDouble() * 50 + 50;
        final date = startDate.add(Duration(days: index));
        return WeightData(weight: weight, date: date);
      });
      chartDataMapList = chartData
          .map((data) => {'weight': data.weight, 'date': data.date})
          .toList();
    } else {
      chartDataMapList = chartData
          .map((data) => {'weight': data.weight, 'date': data.date})
          .toList();
    }
  }

  late List<Map<String, dynamic>> chartDataMapList;
  /////////////////
  @override
  void initState() {
    callchartlisthive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 14, right: 14, bottom: 0),
            child: Container(
              color: Colors.deepOrangeAccent.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 14.0),
                    child: Text(
                      'Weight',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cbold',
                          fontSize: 14),
                    ),
                  ),
                  todayweightadded
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Plz add weight next day',
                              style: TextStyle(fontSize: 12)),
                        )
                      : TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Weight',
                              content: Column(
                                children: [
                                  SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: SizedBox(
                                      height: Get.size.height * 0.3 / 4,
                                      child: TextFormField(
                                        controller: weightalertinputcontr,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          hintText: 'Weight',
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                const BorderSide(width: 0.1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0.1,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        );
                                      },
                                    ),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (states) {
                                        return const BorderSide(
                                            color: Colors.deepOrange);
                                      },
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 7.0,
                                        left: 15,
                                        right: 15,
                                        bottom: 7),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'csemibold',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (weightalertinputcontr
                                            .text.isNotEmpty) {
                                          int check = int.parse(
                                              weightalertinputcontr.text
                                                  .toString());
                                          if (check > 70 || check < 15) {
                                            Get.snackbar('Not Correct Weight',
                                                ' According  To your History');
                                          } else {
                                            final chartdatain = WeightchartData(
                                              weight: double.parse(
                                                  weightalertinputcontr.text),
                                              date: DateTime.now(),
                                            );
                                            await chartbox.add(chartdatain);
                                            chartdatain.save();
                                            Get.snackbar(
                                                weightalertinputcontr.text,
                                                'Weight Added');
                                            weightalertinputcontr.clear();
                                          }
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'charting Busy try next Time: $e')),
                                        );
                                      }
                                      setState(() {
                                        todayweightadded = true;
                                      });
                                      Get.back();
                                    },
                                    style: ButtonStyle(shape:
                                        MaterialStateProperty.resolveWith<
                                            OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        );
                                      },
                                    )),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 7.0,
                                          left: 15,
                                          right: 15,
                                          bottom: 7),
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'cbold',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            );
                          },
                          child: const Text('Add +',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'cbold',
                                  fontSize: 13)))
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 14, right: 14, bottom: 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4 / 1,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                backgroundColor: Colors.deepOrangeAccent.withOpacity(0.1),
                borderColor: Colors.transparent,
                // ... other properties
                title: ChartTitle(),
                // primaryXAxis: DateTimeAxis(),
                primaryXAxis: DateTimeAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    minorGridLines: const MinorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                    minorTickLines: const MinorTickLines(width: 0),
                    placeLabelsNearAxisLine: false,
                    axisLine: const AxisLine(width: 0)),

                // here grid is started
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                  minimum: 1,
                  maximum: 100,
                  visibleMaximum: 100,
                  rangePadding: ChartRangePadding.round,

                  // edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(width: 0),
                  minorGridLines: const MinorGridLines(width: 30),
                  axisLine: const AxisLine(width: 0),
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                    width: 0,
                    color: Colors.deepOrange,
                  ),
                ),
                // here grid is end where show on background
                series: <SplineAreaSeries<Map<String, dynamic>, DateTime>>[
                  SplineAreaSeries<Map<String, dynamic>, DateTime>(
                    color: Colors.black,
                    borderColor: Colors.black,
                    animationDelay: 1,
                    animationDuration: 2000,
                    dataSource: chartDataMapList,
                    xValueMapper: (data, _) => data['date'],
                    yValueMapper: (data, _) => data['weight'],
                    borderWidth: 2,
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 87, 34, 0.3),
                        Colors.deepOrange,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderGradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black45,
                      ],
                      stops: [0.0, 0.5],
                    ),
                    // here to show a points line circle
                    markerSettings: const MarkerSettings(
                      borderWidth: 0.8,
                      color: Colors.deepOrange,
                      isVisible: true,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

/////////////////////// try calender exa1 here

class Calenderaj extends StatefulWidget {
  const Calenderaj({super.key});

  @override
  State<Calenderaj> createState() => _CalenderajState();
}

class _CalenderajState extends State<Calenderaj> {
  DateTime? calenderSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 10),
              blurRadius: 20,
            )
          ]),
          child: CalendarFlutterAj(
            selectedDate: (selectedDate) {
              calenderSelectedDate = selectedDate;
              debugPrint('$selectedDate');
            },
            backArrow: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 177, 172, 172)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(31, 163, 151, 151),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 10, right: 4, bottom: 4.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 156, 149, 149),
                  size: 12,
                ),
              ),
            ),
            forwardArrow: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: const Color.fromARGB(255, 177, 172, 172)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(31, 163, 151, 151),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 5, right: 8, bottom: 4.0),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color.fromARGB(255, 156, 149, 149),
                  size: 12,
                ),
              ),
            ),
            calenderBackgroundColor: Colors.white,
            selectedDayColor: Colors.deepOrange,
            selectedDayWidget: const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
            calenderSelectedDateBackgroundcolor: Colors.deepOrange,
            calenderSelectedDateColor: Colors.white,
            showCalenderSelectedDateBackgroundcolor: true,
            calenderSelectedDateBorderRadius: BorderRadius.circular(10),
            calenderSelectedDateFontSize: 17,
            dayTextStyle: const TextStyle(
              color: Colors.black,
            ),
            monthBackgroundColor: Colors.white,
            monthTextStyle: const TextStyle(
              color: Colors.black,
            ),
            weekdaysTextStyle:
                const TextStyle(color: Color.fromARGB(255, 180, 176, 176)),
            yearBackgroundColor: Colors.white,
            yearTextStyle: const TextStyle(
              color: Colors.black,
            ),
            calenderUnSelectedDatesColor: Colors.black54,
            yearPopHeadingText: "year",
            yearPopHeadingTextStyle: const TextStyle(
              color: Colors.black,
            ),
            yearsListTextStyle: const TextStyle(
              color: Colors.black,
            ),
            monthPopHeadingText: "month",
            monthPopHeadingTextStyle: const TextStyle(
              color: Colors.black,
            ),
            monthsListTextStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
