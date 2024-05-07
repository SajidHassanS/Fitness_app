import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout/vplansexc.dart';

import 'plansmodel/getpplansdata.dart';
import 'plansmodel/plansmodelclass.dart';
import 'selectplanspage.dart';

class Addplanspage extends StatefulWidget {
  const Addplanspage({super.key});

  @override
  State<Addplanspage> createState() => _AddplanspageState();
}

class _AddplanspageState extends State<Addplanspage> {
  TextEditingController wkcustomtitletext = TextEditingController();
  TextEditingController wkcostumdesctxt = TextEditingController();
  final box = Plansbox.data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: Get.size.height * 0.23 / 1,
                  ),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: Get.size.height * 0.19 / 1,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 239, 234),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 35.0, left: 18, right: 18, bottom: 40),
                        child: Column(
                          children: const [
                            Expanded(
                              child: Text(
                                'Create a New Plan',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cbold'),
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'You can create and edit your own workout by chossing from various exercise',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'clight',
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.size.height * 0.152 / 1,
                    left: Get.size.width * 0.30 / 1,
                    child: Center(
                      child: CustomPaint(
                        painter: _DomePainter(
                            color: const Color.fromARGB(255, 250, 250, 250)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 40, right: 40, bottom: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(60)),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: '',
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Workout Title',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'csemibold',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: wkcustomtitletext,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              hintText: 'Workout Title',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0.5,
                                                              color: Colors
                                                                  .blueGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                    width: 0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Description',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'csemibold',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: wkcostumdesctxt,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              hintText: 'Description',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 0.5,
                                                              color: Colors
                                                                  .blueGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                    width: 0.5),
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
                                          shape: MaterialStateProperty
                                              .resolveWith<OutlinedBorder>(
                                            (states) {
                                              return RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              );
                                            },
                                          ),
                                          side: MaterialStateProperty
                                              .resolveWith<BorderSide>(
                                            (states) {
                                              return const BorderSide(
                                                  color: Colors.deepOrange);
                                            },
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            left: 28,
                                            right: 28,
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'csemibold',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            try {
                                              Get.to(Selectplanspage(
                                                  title: wkcustomtitletext.text,
                                                  desc: wkcostumdesctxt.text));
                                              wkcustomtitletext.clear();
                                              wkcostumdesctxt.clear();
                                              // navigator!.pop(context);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Try Again Later${e.toString()}')));
                                            }
                                          },
                                          style: ButtonStyle(shape:
                                              MaterialStateProperty.resolveWith<
                                                  OutlinedBorder>(
                                            (states) {
                                              return RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              );
                                            },
                                          )),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'cbold',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ],
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 / 1,
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (BuildContext context, dynamic box, _) {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = box.values.toList().cast<Plansmodelclass>();
                        var nooflist = index + 1;
                        return InkWell(
                          onTap: () {
                            Get.to(Startwkonebyoneforplans(vlistno: index));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blueGrey.withOpacity(0.1),
                                        offset: const Offset(0, 0.2),
                                        blurRadius: 5,
                                        spreadRadius: 0),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 11, left: 8, right: 8, bottom: 11),
                                child: Stack(
                                  children: [
                                    ListTile(
                                      leading: Transform.scale(
                                        scale: 1.2,
                                        child: Container(
                                          width: Get.size.width * 0.15 / 1,
                                          height: Get.size.height * 0.25 / 1,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 239, 234),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text(
                                              nooflist.toString(),
                                              overflow: TextOverflow.visible,
                                              style: const TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        data[index].title.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'csemibold'),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          const Icon(
                                            Icons.fitness_center_outlined,
                                            size: 14,
                                          ),
                                          Text(
                                            ' ${data[index].desc.toString()}',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'csemibold'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: PopupMenuButton(
                                            shape: BeveledRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 255, 121, 64),
                                                  width: 1,
                                                )),
                                            initialValue: 23,
                                            elevation: 40,
                                            splashRadius: 22,
                                            position: PopupMenuPosition.over,
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                  onTap: () {
                                                    data[index].delete();
                                                  },
                                                  value: 1,
                                                  child: const Text('Delete'),
                                                ),
                                              ];
                                            }))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////
class _DomePainter extends CustomPainter {
  final Color color;
  _DomePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    Path path = Path();
    path.lineTo(0, size.height);
    path.cubicTo(
        0, size.height, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width * 0.94, size.height, size.width * 0.83,
        size.height * 0.65, size.width * 0.72, size.height * 0.31);
    path.cubicTo(size.width * 0.67, size.height * 0.12, size.width * 0.59,
        size.height * 0.01, size.width * 0.51, 0);
    path.cubicTo(
        size.width * 0.51, 0, size.width * 0.51, 0, size.width * 0.51, 0);
    path.cubicTo(size.width * 0.42, -0.01, size.width * 0.34,
        size.height * 0.11, size.width * 0.27, size.height * 0.31);
    path.cubicTo(size.width * 0.17, size.height * 0.65, size.width * 0.06,
        size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height, 0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//////////
