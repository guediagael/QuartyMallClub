class Partner {
  int id;
  String name;
  String description;
  String image;

  Partner(this.id, this.name, this.description, this.image);

  @override
  String toString() {
    return 'Partner{id: $id, name: $name, description: $description, image: $image}';
  }

}
