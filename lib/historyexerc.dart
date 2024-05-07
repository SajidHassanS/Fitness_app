import 'package:calendar_flutter_aj/calender_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'plansmodel/getpplansdata.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Vallactivity extends StatefulWidget {
  const Vallactivity({super.key});

  @override
  State<Vallactivity> createState() => _VallactivityState();
}

class _VallactivityState extends State<Vallactivity> {
  void allweeklymonthlycall(checkvalue) async {
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

    if (checkvalue == 0) {
      List<Map<dynamic, dynamic>> dataList = [];

      for (var item in activityBox) {
        if (item is Map<dynamic, dynamic>) {
          dataList.add(item);
        }
      }
      dataForDate = dataList;
    } else if (checkvalue == 1) {
      ///////////// for compare date

      final sixDaysAgo = now.subtract(const Duration(days: 6));
      final formattedDate = DateFormat.yMd().format(sixDaysAgo);
      final formattedDateTime = DateFormat.yMd().parse(formattedDate);
      ///////////// for compare date
      final filteredData = activityBox
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
      dataForDate = dataList;
    } else {
      ///////////// for compare date

      final sixDaysAgo = now.subtract(const Duration(days: 29));
      final formattedDate = DateFormat.yMd().format(sixDaysAgo);
      final formattedDateTime = DateFormat.yMd().parse(formattedDate);
      ///////////// for compare date
      final filteredData = activityBox
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
      dataForDate = dataList;
    }

    setState(() {
      _selectedbtnIndex = checkvalue;
    });
  }

  /////////
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

    final filteredData =
        activityBox.where((data) => data['date'] == formattedDate).toList();
    List<Map<dynamic, dynamic>> dataList = [];
    for (var item in filteredData) {
      if (item is Map<dynamic, dynamic>) {
        dataList.add(item);
      }
    }

    dataForDate = dataList;

    setState(() {});
  }

  List<Map<dynamic, dynamic>> dataForDate = [];

/////// all var here
  String? todayactivitydate;
  DateTime? calenderSelectedDate = DateTime.now();
  int _selectedbtnIndex = 0;
/////// all var here

  final box = Plansbox.data();
  @override
  void initState() {
    allweeklymonthlycall(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Activity',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 241, 244, 245),
                  offset: Offset(0, 1),
                  blurRadius: 20,
                )
              ]),
              width: MediaQuery.of(context).size.width * 0.9 / 1,
              child: CupertinoSlidingSegmentedControl<int>(
                thumbColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                // ignore: prefer_for_elements_to_map_fromiterable
                children: Map.fromIterable(
                  [0, 1, 2],
                  key: (index) => index,
                  value: (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      index == 0 ? 'All' : (index == 1 ? 'Weekly' : 'Monthly'),
                      style: TextStyle(
                        color: _selectedbtnIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                groupValue: _selectedbtnIndex,
                onValueChanged: (val) async {
                  allweeklymonthlycall(val);
                  setState(() {
                    _selectedbtnIndex = val!;
                  });
                },
              ),
            ),
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
                      // debugPrint('$selectedDate');
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75 / 1,
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
                                Text(
                                  todayactivitydate.toString(),
                                  style: const TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: Colors.black,
                                      fontSize: 10),
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

//////////
