class Restaurant {
  final String _name;
  final String _description;
  final List<dynamic> _imagenes;
  final double _rating; // Puede ser null
  final int _count; // Puede ser null
  final double? _latitude; // Puede ser null
  final double? _longitude; // Puede ser null

  Restaurant(
    this._name,
    this._description,
    this._imagenes,
    this._rating,
    this._count,
    this._latitude,
    this._longitude,
  );

  String get name => _name;
  String get description => _description;
  List<dynamic> get imagenes => _imagenes;
  double get rating => _rating;
  int get count => _count;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
}
