import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'plansmodelclass.g.dart';

@HiveType(typeId: 0)
class Plansmodelclass extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String desc;
  @HiveField(2)
  List<Exercises> exercises;

  Plansmodelclass(
      {required this.title, required this.desc, required this.exercises});
}

@HiveType(typeId: 1)
class Exercises {
  @HiveField(0)
  dynamic title;
  @HiveField(1)
  dynamic thumbUrl;
  @HiveField(2)
  dynamic imageUrl;

  Exercises(
      {required this.title, required this.thumbUrl, required this.imageUrl});
}

///// here show chart data
@HiveType(typeId: 2)
class WeightchartData extends HiveObject {
  @HiveField(0)
  double weight;

  @HiveField(1)
  DateTime date;

  WeightchartData({required this.weight, required this.date});
}


















// final planBox = Hive.box<Plan>('plans');

// // Add a new plan
// final newPlan = Plan(
//   title: 'My New Plan',
//   desc: 'This is my new workout plan',
//   exercises: [
//     {
//       'title': 'Jumping Jacks',
//       'thumbUrl': 'assets/exercises/jumping-jacks-thumb.png',
//       'imageUrl': 'assets/exercises/jumping-jacks.png',
//     },
//     {
//       'title': 'Pushups',
//       'thumbUrl': 'assets/exercises/pushups-thumb.png',
//       'imageUrl': 'assets/exercises/pushups.png',
//     },
//   ],
// );
// planBox.add(newPlan);

// // Retrieve a plan and update its exercises
// final existingPlan = planBox.get(0);
// existingPlan.exercises.add({
//   'title': 'Squats',
//   'thumbUrl': 'assets/exercises/squats-thumb.png',
//   'imageUrl': 'assets/exercises/squats.png',
// });
// existingPlan.save();

// // Retrieve a plan and remove an exercise
// final existingPlan2 = planBox.get(0);
// existingPlan2.exercises.removeAt(0);
// existingPlan2.save();
/////////////////////////////////////////////////////////////////////////////////////////////////

// Open the box
// final plansBox = await Hive.openBox<Plansmodelclass>('plans');

// Create two plans
// final plan1 = Plansmodelclass(
//   title: 'Plan 1',
//   desc: 'This is the first plan',
//   exercises: [
//     Exercise(
//       title: 'Jumping Jacks',
//       thumbUrl: 'assets/wk/thumbs/33.gif',
//       imageUrl: 'assets/wk/33.gif',
//     ),
//     Exercise(
//       title: 'Dynamic Chest',
//       thumbUrl: 'assets/wk/thumbs/52.gif',
//       imageUrl: 'assets/wk/52.gif',
//     ),
//   ],
// );

// final plan2 = Plansmodelclass(
//   title: 'Plan 2',
//   desc: 'This is the second plan',
//   exercises: [
//     Exercise(
//       title: 'Punches',
//       thumbUrl: 'assets/wk/thumbs/54.gif',
//       imageUrl: 'assets/wk/54.gif',
//     ),
//     Exercise(
//       title: 'Sit-ups',
//       thumbUrl: 'assets/wk/thumbs/47.gif',
//       imageUrl: 'assets/wk/47.gif',
//     ),
//   ],
// );

// // Add the plans to the box
// plansBox.add(plan1);
// plansBox.add(plan2);

// // Close the box when done
// await plansBox.close();
