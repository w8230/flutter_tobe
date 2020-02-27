class Employee{
  int seq;
  String email;
  String password;
  String name;
  String emp_no;
  String dept;
  String tel;
  String msg;

  Employee({this.seq , this.email , this.password ,  this.name , this.emp_no , this.dept , this.tel , this.msg });
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      seq     : json['seq'] as int,
      email     : json['email'] as String,
      password     : json['password'] as String,
      name    : json['name'] as String,
      emp_no  : json['emp_no'] as String,
      dept    : json['dept'] as String,
      tel     : json['tel'] as String,
      msg     : json['msg'] as String
    );
  }
}