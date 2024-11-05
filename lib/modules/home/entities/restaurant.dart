import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String _name;
  final String _description;
  final List<dynamic> _imagenes;
  final double _rating;
  final int _count;
  final GeoPoint _direction;

  Restaurant(
    this._name,
    this._description,
    this._imagenes,
    this._rating,
    this._count,
    this._direction,
  );

  String get name => _name;
  String get description => _description;
  List<dynamic> get imagenes => _imagenes;
  double get rating => _rating;
  int get count => _count;
  GeoPoint get direction => _direction;
}

//18.83896591214572, -99.1993756079529