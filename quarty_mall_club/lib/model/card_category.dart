class CardCategory {
  int id;
  String name;
  String imageUrl;

  CardCategory(this.id, this.name, this.imageUrl);

  @override
  String toString() {
    return 'CardCategory{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}
