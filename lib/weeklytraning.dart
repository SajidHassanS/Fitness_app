import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:math';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'modellist.dart';
import 'opencatg.dart';

class Weekltraining extends StatefulWidget {
  final int id;
  final String title;
  final String image;

  final Color colorname;
  // final String tagnamewk;
  const Weekltraining({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.colorname,
    // required this.tagnamewk,
  }) : super(key: key);

  @override
  State<Weekltraining> createState() => _WeekltrainingState();
}

class _WeekltrainingState extends State<Weekltraining> {
  int selectedButtonIndex1 = 0;
  int selectedButtonIndex2 = 1;
  int selectedButtonIndex3 = 2;
  int selectedButtonIndex4 = 3;

  List<String> buttonTitles = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  late DateTime _lastClickDate;
  late bool _isButtonEnabled;
  late int bignerweeks;
  // int veiwbyid;

///// for hive box
  late Box<dynamic> weeklytrbox;
///// for hive box
  @override
  void initState() {
    super.initState();
    _loadLastClickDate();
  }

  void _loadLastClickDate() {
    weeklytrbox = Hive.box<dynamic>('profile');
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));

    final String? lastClickDateString =
        weeklytrbox.get('lastClickDate') ?? yesterday.toString();
    if (lastClickDateString != null) {
      _lastClickDate = DateFormat('yyyy-MM-dd').parse(lastClickDateString);
    } else {
      _lastClickDate = DateTime(0);
    }
    if (widget.id == 1) {
      bignerweeks = weeklytrbox.get('bignerweeks') ?? 0;
    } else {
      bignerweeks = weeklytrbox.get('intermediatweeks') ?? 0;
    }
    _isButtonEnabled = !_isSameDay(_lastClickDate, DateTime.now());
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: widget.colorname,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(251, 250, 250, 250),
      bottomNavigationBar: Container(
        height: Get.size.height * 0.5 / 4,
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 8, right: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              if (_isButtonEnabled) {
                // Generate a random category index
                int categoryIndex = Random().nextInt(categories.length);

                // Get a random exercise index for the selected category
                int exerciseIndex = Random()
                    .nextInt(categories[categoryIndex].exercises.length);

                // Get the category name
                String categoryName = categories[categoryIndex].name;
                if (widget.id == 1) {
                  weeklytrbox.put('bignerweeks', bignerweeks + 1);
                } else {
                  weeklytrbox.put('intermediatweeks', bignerweeks + 1);
                }

                // Navigate to the Startwkonebyone screen and pass the category name and index
                Get.to(Startwkonebyone(
                    catgname: categoryName, vindex2: exerciseIndex));
                // Update the last click date to today
                _lastClickDate = DateTime.now();
                final String lastClickDateString =
                    DateFormat('yyyy-MM-dd').format(_lastClickDate);
                weeklytrbox.put('lastClickDate', lastClickDateString);
                setState(() {
                  _isButtonEnabled = false;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        _isButtonEnabled ? 'Start Workout' : 'Start Next Day',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'cbold')),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.colorname,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: Get.size.height * 1.5 / 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Image.asset(
                    widget.image,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: 85,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 252, 230, 224),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.av_timer_outlined,
                          size: 16,
                          color: Colors.deepOrange,
                        ),
                        Text(
                          '4 Weeks',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 13,
                              fontFamily: 'clight'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 9, left: 20.0, right: 20, bottom: 9),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 210, 210, 210)
                              .withOpacity(0.05),
                          offset: const Offset(1, 1),
                          blurRadius: 10)
                    ]),
                child: ExpansionTile(
                  collapsedShape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      1),
                  collapsedIconColor: Colors.black,
                  iconColor: Colors.black,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  initiallyExpanded: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: const Text(
                    'Week 1',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'csemibold'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 28.0,
                        runSpacing: 20,
                        children: List.generate(
                          buttonTitles.length,
                          (index) => index == 7
                              ? Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 254, 241, 202),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 8, bottom: 8, right: 12),
                                    child: Image.asset(
                                      'assets/images/trophy.png',
                                      height: 46,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   selectedButtonIndex1 = index;
                                    // });
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return 0;
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return bignerweeks >= index
                                          ? Colors.deepOrange
                                          : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        );
                                      },
                                    ),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Colors.deepOrange);
                                        }
                                        return BorderSide(
                                            color: bignerweeks >= index
                                                ? Colors.deepOrange
                                                : Colors.grey);
                                      },
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 4,
                                        right: 4,
                                        bottom: 18),
                                    child: Text(
                                      buttonTitles[index],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: bignerweeks >= index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 9, left: 20.0, right: 20, bottom: 9),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 210, 210, 210)
                              .withOpacity(0.05),
                          offset: const Offset(1, 1),
                          blurRadius: 10)
                    ]),
                child: ExpansionTile(
                  collapsedShape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      1),
                  collapsedIconColor: Colors.black,
                  iconColor: Colors.black,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: const Text(
                    'Week 2',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'csemibold'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 28.0,
                        runSpacing: 20,
                        children: List.generate(
                          buttonTitles.length,
                          (index) => index == 7
                              ? Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 254, 241, 202),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      'assets/images/trophy.png',
                                      height: 46,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   selectedButtonIndex2 = index;
                                    // });
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return 0;
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return bignerweeks >= index + 6
                                          ? Colors.deepOrange
                                          : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        );
                                      },
                                    ),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Colors.deepOrange);
                                        }
                                        return BorderSide(
                                            color: bignerweeks >= index + 6
                                                ? Colors.deepOrange
                                                : Colors.grey);
                                      },
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 4,
                                        right: 4,
                                        bottom: 18),
                                    child: Text(
                                      buttonTitles[index],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: bignerweeks >= index + 6
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 9, left: 20.0, right: 20, bottom: 9),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 210, 210, 210)
                              .withOpacity(0.05),
                          offset: const Offset(1, 1),
                          blurRadius: 10)
                    ]),
                child: ExpansionTile(
                  collapsedShape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      1),
                  collapsedIconColor: Colors.black,
                  iconColor: Colors.black,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: const Text(
                    'Week 3',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'csemibold'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 28.0,
                        runSpacing: 20,
                        children: List.generate(
                          buttonTitles.length,
                          (index) => index == 7
                              ? Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 254, 241, 202),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      'assets/images/trophy.png',
                                      height: 46,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   selectedButtonIndex3 = index;
                                    // });
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return 0;
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return bignerweeks >= index + 13
                                          ? Colors.deepOrange
                                          : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        );
                                      },
                                    ),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Colors.deepOrange);
                                        }
                                        return BorderSide(
                                            color: bignerweeks >= index + 13
                                                ? Colors.deepOrange
                                                : Colors.grey);
                                      },
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 4,
                                        right: 4,
                                        bottom: 18),
                                    child: Text(
                                      buttonTitles[index],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: bignerweeks >= index + 13
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 9, left: 20.0, right: 20, bottom: 9),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 210, 210, 210)
                              .withOpacity(0.05),
                          offset: const Offset(1, 1),
                          blurRadius: 10)
                    ]),
                child: ExpansionTile(
                  collapsedShape: ShapeBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      1),
                  collapsedIconColor: Colors.black,
                  iconColor: Colors.black,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: const Text(
                    'Week 4',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'csemibold'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 28.0,
                        runSpacing: 20,
                        children: List.generate(
                          buttonTitles.length,
                          (index) => index == 7
                              ? Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 254, 241, 202),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      'assets/images/trophy.png',
                                      height: 46,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   selectedButtonIndex4 = index;
                                    // });
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return 0;
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return bignerweeks >= index + 20
                                          ? Colors.deepOrange
                                          : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        );
                                      },
                                    ),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Colors.deepOrange);
                                        }
                                        return BorderSide(
                                            color: bignerweeks >= index + 20
                                                ? Colors.deepOrange
                                                : Colors.grey);
                                      },
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0,
                                        left: 4,
                                        right: 4,
                                        bottom: 18),
                                    child: Text(
                                      buttonTitles[index],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: bignerweeks >= index + 20
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
