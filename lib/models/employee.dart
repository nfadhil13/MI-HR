class Employee {
  final int id;
  final String imageURL;
  final String email;
  final String name;
  final String position;


  Employee({
    required this.id,
    this.imageURL = "http://192.168.4.138:8069/web/image?model=hr.employee&id=6&field=image_1920" ,
    required this.email,
    required this.name,
    required this.position
  });

}