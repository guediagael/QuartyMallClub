class Profile{
  String name;
  String surname;
  String birthday;
  String city;
  String phone;

  Profile(this.name, this.surname, this.birthday, this.city, this.phone);

  @override
  String toString() {
    return 'Profile{name: $name, surname: $surname, birthday: $birthday, city: $city, phone: $phone}';
  }


}