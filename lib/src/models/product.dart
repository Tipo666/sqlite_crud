class Product {
  int id;
  String name;

  Product(this.id, this.name);

  ///Método toMap(Map<String, dynamic>)
  ///
  ///
  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  ///Método fromMap(Map<String, dynamic>)
  ///
  ///
  ///
  ///
  ///
  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
