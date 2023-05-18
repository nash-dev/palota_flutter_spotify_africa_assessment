class Category {
  final String href;
  final String name;
  final String type;
  final String icons;
  final int id;

  Category(this.name, this.href, this.type, this.icons, this.id);

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
        json['name'], json['href'], json['type'], json['icons'], json['id']);
  }
}
