// ignore_for_file: unnecessary_getters_setters
import 'dart:math';

class IMCModel {
  int _id = 0;
  double _mass = 0;
  double _height = 0;
  String _classification = "";

  IMCModel(this._id, this._mass, this._height, this._classification);
  IMCModel.empty() {
    _id = 0;
    _mass = 0;
    _height = 0;
    _classification = "";
  }

  int get id => _id;
  double get mass => _mass;
  double get height => _height;
  double get imc {
    if (mass > 0 && height > 0) {
      return double.parse((_mass / pow(_height, 2)).toStringAsFixed(2));
    } else {
      return 0;
    }
  }

  String get classification => _classification.isEmpty ? _checkClassification(imc) : _classification;

  set id(int id) {
    _id = id;
  }

  set mass(double mass) {
    _mass = mass;
  }

  set height(double height) {
    _height = height;
  }

  set classification(String? classification) {
    _classification = classification ?? _checkClassification(imc);
  }

  String _checkClassification(double imc) {
    if (imc < 16) {
      return "Magreza Grave";
    } else if ((imc >= 16) && (imc < 17)) {
      return "Magreza Moderada";
    } else if ((imc >= 17) && (imc < 18.5)) {
      return "Magreza Leve";
    } else if ((imc >= 18.5) && (imc < 25)) {
      return "Eutrófico (Peso ideal)";
    } else if ((imc >= 25) && (imc < 30)) {
      return "Sobrepeso";
    } else if ((imc >= 30) && (imc < 35)) {
      return "Obesidade grau I";
    } else if ((imc >= 35) && (imc < 40)) {
      return "Obesidade grau II (severa)";
    } else {
      return "Obesidade grau III (mórbida)";
    }
  }
}
