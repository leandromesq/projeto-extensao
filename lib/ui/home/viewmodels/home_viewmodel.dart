import 'package:flutter/material.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';

class HomeViewmodel extends ChangeNotifier {
  final RachadinhaRepository _repository;
  HomeViewmodel(this._repository);
}
