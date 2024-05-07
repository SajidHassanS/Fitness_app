import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:workout/plansmodel/plansmodelclass.dart';
import 'package:workout/setting.dart';

import 'opencatg.dart';

class CountdownContforplans extends GetxController {
  final prfilebox = Hive.box<dynamic>('profile');

  Timer? _timer;
  final _countdownValue = 0.obs;
  final _isPaused = false.obs;

  int get countdownValue => _countdownValue.value;

  @override
  void onInit() {
    super.onInit();
    _countdownValue.value = prfilebox.get('durationbox') ?? 60;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused.value) {
        if (_countdownValue.value > 0) {
          _countdownValue.value--;
        } else {
          _timer!.cancel();
          onTimerEnd();
        }
      }
    });
  }

  void pauseTimer() {
    _isPaused.value = true;
  }

  void resumeTimer() {
    _isPaused.value = false;
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _countdownValue.value = prfilebox.get('durationbox') ?? 60;
  }

  void onTimerEnd() {
    // Define your actions here
  }

  @override
  void onClose() {
    stopTimer();
    _timer?.cancel();
    super.onClose();
  }
}

class Startwkonebyoneforplans extends StatefulWidget {
  final int vlistno;
  final int? vexercno;
  final String? vtitlefromskip;
  const Startwkonebyoneforplans(
      {super.key, required this.vlistno, this.vexercno, this.vtitlefromskip});
  @override
  State<Startwkonebyoneforplans> createState() =>
      _StartwkonebyoneforplansState();
}

class _StartwkonebyoneforplansState extends State<Startwkonebyoneforplans> {
  Future<List<Plansmodelclass>> _loadExercises() async {
    try {
      final box = await Hive.openBox<Plansmodelclass>('plansbox');
      final planslist = box.values.toList();
      return planslist;
    } catch (e) {
      Get.snackbar(e.toString(), 'Try Later');
      return [];
    }
  }

  final prfilebox = Hive.box<dynamic>('profile');
  FlutterTts flutterTts = FlutterTts();
  void texttospeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(prfilebox.get('ttsspeed') ?? 0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void ttsstop() async {
    await flutterTts.stop();
  }

  void ttspause() async {
    await flutterTts.pause();
  }

  bool play = true;
  int indexplus = 0;
  int totalexcersanplength = 0;
  dynamic appbartitlev = 'Workout';

  ///////// start of timer
  final CountdownContforplans countdownControllercall =
      Get.put(CountdownContforplans());
  CountdownContforplans findsec = Get.find<CountdownContforplans>();
  @override
  void initState() {
    super.initState();
    // checkremtimef();
    countdownControllercall.startTimer();
    prfilebox.get('soundonoff') ?? true ? _loadExercises() : flutterTts.stop();
    setState(() {
      indexplus = widget.vexercno ?? 0;
      appbartitlev = widget.vtitlefromskip ?? 'Workout';
    });
    calltsinitialf();
  }

  //// // for get categories list data only
  Future<void> calltsinitialf() async {
    final box = await Hive.openBox<Plansmodelclass>('plansbox');
    final planslisttitle = box.values.toList();
    setState(() {
      appbartitlev = planslisttitle[widget.vlistno].exercises[indexplus].title;
    });
    String initialspeach =
        '${planslisttitle[widget.vlistno].exercises[indexplus].title} . for ${prfilebox.get('durationbox') ?? 25} Seconds.';
    return texttospeech(initialspeach);
  }

  @override
  void dispose() {
    ttsstop();
    flutterTts.stop();
    // countdownControllercall.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
                flutterTts.stop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            appbartitlev,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  soundsheet();
                },
                icon: const Icon(
                  Icons.volume_up_outlined,
                  color: Colors.black,
                )),
          ],
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: FutureBuilder<List<Plansmodelclass>>(
            future: _loadExercises(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No plans found'));
              }
              // final plans = snapshot.data!;
              final plans = snapshot.data!;
              // final boxx = snapshot.data as Box<Plansmodelclass>;
              final exercises = plans[widget.vlistno].exercises;
              totalexcersanplength = exercises.length - 1;

              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(exercises[indexplus].imageUrl.toString()),
                  const Spacer(),
                  Column(
                    children: [
                      Obx(() {
                        if (findsec._countdownValue.value == 0) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (indexplus == totalexcersanplength) {
                              Get.off(Trophypage(
                                  trophytotalexcer: exercises.length));
                            } else {
                              Get.off(Skipwpforplans(
                                  vlistnoforskip: widget.vlistno,
                                  vexercnofornexskip: indexplus + 1,
                                  excercisetittle:
                                      exercises[indexplus + 1].title.toString(),
                                  exceriseimage: exercises[indexplus]
                                      .thumbUrl
                                      .toString()));
                            }
                          });
                          return Container();
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            countdownControllercall.startTimer();
                          });
                          return Text(
                            '${findsec._countdownValue}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'cbold',
                                fontSize: 55,
                                fontWeight: FontWeight.bold),
                          );
                        }
                      }),
                      const Text(
                        'Seconds',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'clight',
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: Get.size.height * 0.15 / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: Get.size.height * 0.15 / 1,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 239, 234),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0,
                                      left: 18,
                                      right: 18,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (indexplus == 0) {
                                              null;
                                            } else {
                                              // _stopTimer();
                                              countdownControllercall
                                                  .stopTimer();
                                              ttsstop();
                                              setState(() {
                                                countdownControllercall
                                                    .startTimer();
                                                prfilebox.get('soundonoff') ??
                                                        true
                                                    ? texttospeech(
                                                        '${exercises[indexplus - 1].title.toString()} . for ${prfilebox.get('durationbox') ?? 10} Seconds.')
                                                    : flutterTts.stop();

                                                appbartitlev =
                                                    exercises[indexplus - 1]
                                                        .title;
                                                indexplus = indexplus - 1;
                                              });
                                              // checkremtimef();
                                            }
                                          },
                                          icon: Icon(Icons.arrow_back_ios,
                                              size: 25,
                                              color: indexplus == 0
                                                  ? Colors.grey
                                                  : Colors.black)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.add,
                                            size: 1,
                                            color: Colors.transparent,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.add,
                                            size: 1,
                                            color: Colors.transparent,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            // _stopTimer();
                                            if (indexplus ==
                                                exercises.length - 1) {
                                              Get.off(Trophypage(
                                                  trophytotalexcer:
                                                      exercises.length - 1));
                                              countdownControllercall
                                                  .stopTimer();
                                              ttsstop();
                                            } else {
                                              countdownControllercall
                                                  .stopTimer();
                                              ttsstop();
                                              setState(() {
                                                countdownControllercall
                                                    .startTimer();
                                                prfilebox.get('soundonoff') ??
                                                        true
                                                    ? texttospeech(
                                                        '${exercises[indexplus + 1].title.toString()} . for ${prfilebox.get('durationbox') ?? 10} Seconds.')
                                                    : flutterTts.stop();

                                                appbartitlev =
                                                    exercises[indexplus + 1]
                                                        .title;
                                                indexplus = indexplus + 1;
                                              });
                                              // checkremtimef();
                                            }
                                          },
                                          icon: Icon(Icons.arrow_forward_ios,
                                              size: 25,
                                              color: indexplus ==
                                                      exercises.length - 1
                                                  ? Colors.grey
                                                  : Colors.black)),
                                    ],
                                  )),
                            ),
                          ),
                          Positioned(
                            left: Get.size.width * 0.27 / 1,
                            child: Transform.translate(
                              offset: const Offset(0, -30),
                              child: Transform.rotate(
                                angle: 3.14,
                                child: Center(
                                  child: CustomPaint(
                                    painter: _DomePainterforplans(
                                        color: const Color.fromARGB(
                                            255, 250, 250, 250)),
                                    child: play
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 50,
                                                right: 50,
                                                bottom: 2),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  prfilebox.get('soundonoff') ??
                                                          true
                                                      ? ttspause()
                                                      : flutterTts.stop();
                                                  play = !play;

                                                  countdownControllercall
                                                      .pauseTimer();
                                                });
                                              },
                                              child: Container(
                                                width: Get.size.width * 0.6 / 4,
                                                decoration: BoxDecoration(
                                                    color: Colors.deepOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60)),
                                                child: Image.asset(
                                                    'assets/images/pause.png'),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 50,
                                                right: 50,
                                                bottom: 2),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  play = !play;
                                                  prfilebox.get('soundonoff') ??
                                                          true
                                                      ? texttospeech(
                                                          '${exercises[indexplus].title.toString()} . for ${prfilebox.get('durationbox') ?? 10} Seconds.}')
                                                      : flutterTts.stop();

                                                  countdownControllercall
                                                      .resumeTimer();
                                                });
                                                // checkremtimef();
                                              },
                                              child: Container(
                                                width: Get.size.width * 0.6 / 4,
                                                decoration: BoxDecoration(
                                                    color: Colors.deepOrange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60)),
                                                child: Image.asset(
                                                    'assets/images/play.png'),
                                              ),
                                            ),
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
              );
            }));
  }
}

class _DomePainterforplans extends CustomPainter {
  final Color color;
  _DomePainterforplans({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    Path path = Path();
    path.moveTo(20, 0); // Move to (20,0) to start drawing the path
    path.lineTo(20, size.height); // Draw a line from (20,0) to (20,size.height)
    path.cubicTo(
      20,
      size.height,
      size.width - 20,
      size.height,
      size.width - 20,
      size.height,
    );
    path.cubicTo(
      size.width * 0.94,
      size.height,
      size.width * 0.83,
      size.height * 0.65,
      size.width * 0.72,
      size.height * 0.31,
    );
    path.cubicTo(
      size.width * 0.67,
      size.height * 0.12,
      size.width * 0.59,
      size.height * 0.01,
      size.width * 0.51,
      0,
    );
    path.cubicTo(
      size.width * 0.51,
      0,
      size.width * 0.51,
      0,
      size.width * 0.51,
      0,
    );
    path.cubicTo(
      size.width * 0.42,
      -0.01,
      size.width * 0.34,
      size.height * 0.11,
      size.width * 0.27,
      size.height * 0.31,
    );
    path.cubicTo(
      size.width * 0.17,
      size.height * 0.65,
      size.width * 0.06,
      size.height,
      20,
      size.height,
    );
    path.lineTo(20, 0); // Draw a line from (20,size.height) to (20,0)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

///////////////////////////////////////////////////////
// start for Skip Page
class Skiptimecontforplans extends GetxController {
  final prfilebox = Hive.box<dynamic>('profile');

  Timer? _timer;
  final _countdownValue = 10.obs;
  // final _isPaused = false.obs;

  int get countdownValue => _countdownValue.value;

  @override
  void onInit() {
    super.onInit();
    _countdownValue.value = prfilebox.get('restval') ?? 10;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // if (!_isPaused.value) {
      if (_countdownValue.value > 0) {
        _countdownValue.value--;
      } else {
        _timer!.cancel();
      }
      // }
    });
  }

  void stopTimer() {
    _timer!.cancel();
    _timer = null;

    _countdownValue.value = prfilebox.get('restval') ?? 10;
  }

  @override
  void onClose() {
    stopTimer();
    // _timer?.cancel();
    super.onClose();
  }
}

class Skipwpforplans extends StatefulWidget {
  final int vlistnoforskip;
  final int vexercnofornexskip;
  final String excercisetittle;
  final String exceriseimage;
  const Skipwpforplans(
      {super.key,
      required this.vlistnoforskip,
      required this.vexercnofornexskip,
      required this.excercisetittle,
      required this.exceriseimage});

  @override
  State<Skipwpforplans> createState() => _SkipwpforplansState();
}

class _SkipwpforplansState extends State<Skipwpforplans> {
  final Skiptimecontforplans skiptimecontcall = Get.put(Skiptimecontforplans());
  Skiptimecontforplans skiptimecontfind = Get.find<Skiptimecontforplans>();
  final prfilebox = Hive.box<dynamic>('profile');

  Future<List<Plansmodelclass>> _loadExercises() async {
    try {
      final box = await Hive.openBox<Plansmodelclass>('plansbox');
      final planslist = box.values.toList();

      return planslist;
    } catch (e) {
      Get.snackbar(e.toString(), 'Try Later Skip Time');
      return [];
    }
  }

  Timer? _timercall2;
  Future<void> chkskiptimef() async {
    int sec;

    if (prfilebox.get('restval') == null) {
      sec = 25;
    } else {
      sec = prfilebox.get('restval') ?? 25;
    }
    _timercall2 = Timer.periodic(Duration(seconds: sec), (timer) {
      // skiptimecontcall.stopTimer();
      afterskipcallp();
    });
    // await Future.delayed(Duration(seconds: sec));
  }

  void storactivity() {
    final activityBox = Hive.box<dynamic>('actibox');

    // Get current date and time
    final now = DateTime.now();
    final formattedDate = DateFormat.yMd().format(now);
    final formatdatnow = DateFormat.yMd().add_jm().format(now);

    List<Map<String, dynamic>> newData2 = [
      {
        'excertitle': 'Punches',
        'excerimage': 'assets/wk/thumbs/54.gif',
        'date': formatdatnow,
        'durationstime': 20,
        'calburn': 10,
      },
      {
        'excertitle': 'Jumping Jacks',
        'excerimage': 'assets/wk/thumbs/33.gif',
        'date': formatdatnow,
        'durationstime': 15,
        'calburn': 5,
      }
    ];

    final existingData = activityBox.get('key') ?? newData2;

    ///// random
    int durationstime = Random().nextInt(20) + 1;
    int calburn = Random().nextInt(10) + 1;

    // Update the data with new button click
    final newData = {
      'excertitle': widget.excercisetittle,
      'excerimage': widget.exceriseimage,
      'date': formattedDate,
      'durationstime': durationstime,
      'calburn': calburn,
    };

    existingData.add(newData);

    // Store the updated data in the box
    activityBox.put('key', existingData);
  }

  @override
  void initState() {
    super.initState();
    skiptimecontcall.startTimer();
    storactivity();
    chkskiptimef();
  }

  void _stopTimer() {
    _timercall2?.cancel();
    _timercall2 = null;
  }

  @override
  void dispose() {
    super.dispose();
    // skiptimecontcall.stopTimer();
    _stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Rest',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Stack(
              children: [
                Transform.rotate(
                  angle: 2,
                  child: Obx(
                    () => CircularSeekBar(
                      width: double.infinity,
                      height: 170,
                      progress: skiptimecontfind.countdownValue /
                          prfilebox.get('restval') *
                          100,
                      barWidth: 6,
                      startAngle: 45,
                      sweepAngle: 350,
                      strokeCap: StrokeCap.butt,
                      progressColor: Colors.deepOrange,
                      innerThumbRadius: 5,
                      innerThumbStrokeWidth: 3,
                      innerThumbColor: Colors.deepOrange,
                      outerThumbRadius: 5,
                      outerThumbStrokeWidth: 10,
                      outerThumbColor: Colors.deepOrange,
                      animation: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      child: Transform.translate(
                        offset: const Offset(0, 15),
                        child: Obx(
                          () => Text(
                            '${skiptimecontfind.countdownValue}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 55),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: Text(
              '${prfilebox.get('restval') ?? 25} Seconds',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Plansmodelclass>>(
              future: _loadExercises(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No plans found'));
                }
                final plans = snapshot.data!;

                return InkWell(
                  onTap: afterskipcallp,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LinearProgressIndicator(
                          value: widget.vexercnofornexskip /
                              plans[widget.vlistnoforskip].exercises.length,
                          color: Colors.deepOrange,
                          backgroundColor:
                              Colors.deepOrangeAccent.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const ListTile(
                        title: Text(
                          'Coming Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'cbold'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 15.0, right: 15.0, bottom: 0),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7.0)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: Get.size.height * 0.4 / 4,
                                      width: Get.size.width * 0.4 / 4,
                                      child: Transform.scale(
                                          scale: 2.1,
                                          child: Image.asset(
                                              plans[widget.vlistnoforskip]
                                                  .exercises[
                                                      widget.vexercnofornexskip]
                                                  .imageUrl
                                                  .toString()))),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(plans[widget.vlistnoforskip]
                                    .exercises[widget.vexercnofornexskip]
                                    .title
                                    .toString()),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(children: [
                                  const Icon(
                                    Icons.fitness_center_outlined,
                                    size: 14,
                                  ),
                                  Text(
                                      ' ${prfilebox.get('durationbox') ?? 10}'),
                                ]),
                              ),
                              trailing: SizedBox(
                                  width: Get.size.width * 0.4 / 4,
                                  child: Image.asset('assets/images/play.png')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: afterskipcallp,
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    );
                  },
                ),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) {
                    return const BorderSide(color: Colors.deepOrange);
                  },
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 12.0, left: 30, right: 30, bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'csemibold',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  void afterskipcallp() {
    _stopTimer();
    Get.off(Startwkonebyoneforplans(
      vlistno: widget.vlistnoforskip,
      vexercno: widget.vexercnofornexskip,
      vtitlefromskip: widget.excercisetittle,
    ));
  }
}

// end for Skip Page