import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workout/plansmodel/getpplansdata.dart';
import 'modellist.dart';
import 'plansmodel/plansmodelclass.dart';

class Selectplanspage extends StatefulWidget {
  // const Selectplanspage({super.key});

  final String title;
  final String desc;
  const Selectplanspage({Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  State<Selectplanspage> createState() => _SelectplanspageState();
}

class _SelectplanspageState extends State<Selectplanspage> {
  final box = Plansbox.data();
  List<Map<String, dynamic>> exerciseslist = [];
  int selectedCategoryIndex = 0;
  bool isbuttondone = true;
  bool isselectall = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(251, 250, 250, 250),
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Select Workout',
          style: TextStyle(color: Colors.black),
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
        height: Get.size.height * 0.4 / 4,
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 2.0, left: 8, right: 8, bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: isbuttondone
                  ? () async {
                      final List<Exercises> exercisesList2 = exerciseslist
                          .map((exercise) => Exercises(
                                title: exercise['title'],
                                thumbUrl: exercise['thumbUrl'],
                                imageUrl: exercise['imageUrl'],
                              ))
                          .toList();
                      final planname = Plansmodelclass(
                        title: widget.title,
                        desc: widget.desc,
                        exercises: exercisesList2,
                      );
                      try {
                        await box.add(planname);
                        planname.save();
                        Get.snackbar(widget.title, 'Plan Added');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error saving plan: $e')),
                        );
                      }
                      setState(() {
                        isbuttondone = false;
                      });
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Done',
                        style: TextStyle(
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13 / 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05 / 1,
              child: CupertinoSlidingSegmentedControl<int>(
                thumbColor: Colors.deepOrange,
                backgroundColor: const Color.fromARGB(251, 250, 250, 250),
                // ignore: prefer_for_elements_to_map_fromiterable
                children: Map.fromIterable(
                  categories.asMap().keys,
                  key: (index) => index,
                  value: (index) => Text(
                    categories[index].name,
                    style: TextStyle(
                        color: selectedCategoryIndex == index
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                onValueChanged: (index) {
                  setState(() {
                    selectedCategoryIndex = index!;
                  });
                },
                groupValue: selectedCategoryIndex,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05 / 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Select All'),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(
                          color: Colors.deepOrange,
                          width: 0.5,
                        ),
                        splashRadius: 30,
                        value: isselectall,
                        onChanged: (v) {
                          isselectall
                              ? setState(() {
                                  isselectall = !isselectall;
                                  exerciseslist.clear();
                                })
                              : setState(() {
                                  isselectall = !isselectall;
                                });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        checkColor: Colors.white,
                      ),
                    ),
                  ]),
                  TextButton(
                      onPressed: () {
                        isselectall
                            ? setState(() {
                                isselectall = !isselectall;
                                exerciseslist.clear();
                              })
                            : null;
                      },
                      child: const Text('Cancel')),
                ],
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.7,

              child: ListView.builder(
                itemCount: categories[selectedCategoryIndex].exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  final exercise =
                      categories[selectedCategoryIndex].exercises[index];

                  /////
                  if (isselectall) {
                    final exercisemap = {
                      'title': categories[selectedCategoryIndex]
                          .exercises[index]
                          .title
                          .toString(),
                      'thumbUrl': categories[selectedCategoryIndex]
                          .exercises[index]
                          .thumbUrl
                          .toString(),
                      'imageUrl': categories[selectedCategoryIndex]
                          .exercises[index]
                          .imageUrl
                          .toString(),
                    };
                    exerciseslist.add(exercisemap);
                  }
                  final exerciseTitle = exercise.title;
                  final existingExerciseIndex = exerciseslist
                      .indexWhere((data) => data['title'] == exerciseTitle);
                  final bool isExerciseSelected = existingExerciseIndex != -1;
/////
                  final filtertitle = exerciseslist
                      .where((data) => data['title'] == exercise.title)
                      .toList();

                  return InkWell(
                    autofocus: true,
                    onTap: () {
                      if (!isExerciseSelected) {
                        final exercisemap = {
                          'title': categories[selectedCategoryIndex]
                              .exercises[index]
                              .title
                              .toString(),
                          'thumbUrl': categories[selectedCategoryIndex]
                              .exercises[index]
                              .thumbUrl
                              .toString(),
                          'imageUrl': categories[selectedCategoryIndex]
                              .exercises[index]
                              .imageUrl
                              .toString(),
                        };
                        setState(() {
                          exerciseslist.add(exercisemap);
                        });
                      } else {
                        setState(() {
                          exerciseslist.removeAt(existingExerciseIndex);
                        });
                      }
                    },
                    child: Transform.translate(
                      offset: const Offset(0, -80),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 15.0, right: 15.0, bottom: 8),
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
                                          scale: 1.1,
                                          child:
                                              Image.asset(exercise.thumbUrl))),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(exercise.title),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(children: const [
                                  // Icon(
                                  //   Icons.fitness_center_outlined,
                                  //   size: 14,
                                  // ),
                                  // Text(
                                  //     ' ${prfilebox.get('durationbox') ?? '14 '} Seconds'),
                                ]),
                              ),
                              trailing: Transform.scale(
                                scale: 0.8,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.deepOrange,
                                    width: 0.7,
                                  ),
                                  splashRadius: 30,
                                  value: filtertitle.isNotEmpty || isselectall,
                                  onChanged: (v) {},
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  checkColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              //     }
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
