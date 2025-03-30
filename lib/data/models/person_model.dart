import 'package:rachadinha/data/models/rachadinha_model.dart';

class PersonModel {
  String name;
  double total;
  List<RachadinhaModel> rachadinhas;

  PersonModel({
    this.name = '',
    this.total = 0,
    List<RachadinhaModel>? rachadinhas,
  }) : rachadinhas = rachadinhas ?? [];
}
