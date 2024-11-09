class ShoppingList {
  String? _id;
  String _title;
  String _description;
  String _measure;
  int _quantity;

  ShoppingList(this._title, this._description, this._measure, this._quantity);

  ShoppingList.withId(this._id, this._title, this._description, this._measure, this._quantity);

  String? get id => _id;
  String get title => _title;
  String get description => _description;
  String get measure => _measure;
  int get quantity => _quantity;

  set title (String newTitle) {
    if (newTitle != null && newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description (String newDescription) {
    if (newDescription != null && newDescription.length <=255 ) {
      _description = newDescription;
    }
  }

  set measure (String newMeasure) {
    if (newMeasure != null && newMeasure.length <=255 ) {
      _measure = newMeasure;
    }
  }

  set quantity (int newQuantity) {
    if (newQuantity != null && newQuantity != 0 ) {
      _quantity = newQuantity;
    }
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["measure"] = _measure;
    map["quantity"] = _quantity;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  ShoppingList.fromMap(dynamic k, dynamic o)
      : _id = k,
        _title = o["title"],
        _description = o["description"],
        _measure = o["measure"],
        _quantity = o["quantity"];

}