import 'package:hive/hive.dart';
import 'package:workout/plansmodel/plansmodelclass.dart';

class Plansbox {
  static Box<Plansmodelclass> data() => Hive.box<Plansmodelclass>('plansbox');
}

class Chartbox {
  static Box<WeightchartData> data() => Hive.box<WeightchartData>('chartbox');
}
