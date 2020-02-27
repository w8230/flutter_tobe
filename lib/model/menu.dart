class Menu{
  String menu_id;
  String menu_name;
  int step;

  Menu({this.menu_id , this.menu_name , this.step});
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        menu_id     : json['menu_id'] as String,
        menu_name     : json['menu_name'] as String,
        step     : json['step'] as int
    );
  }
}