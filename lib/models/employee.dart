class Employee {
  final int id;
  final String name;
  final String dob;
  final String phone;
  final String  expLevel;
  final String gender;
  final String confirmation;
  // final String date;

  // static final columns = ['id', 'name', 'dob', 'phone', 'qualification', 'gender', 'date'];

  static final columns = ['id', 'name', 'dob', 'phone', 'expLevel', 'gender', 'confirmation', 'date'];

  Employee(this.id,this.name, this.dob, this.phone, this.expLevel, this.gender, this.confirmation);

  factory Employee.fromMap(Map<String, dynamic> data){
    return Employee(
      data['id'],
      data['name'],
      data['dob'],
      data['phone'],
      data['expLevel'],
      data['gender'],
      data['confirmation'],
      // data['date'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'dob' : dob,
    'phone' : phone,
    'expLevel' : expLevel,
    'gender' : gender,
    'confirmation' : confirmation,
    // 'date' : date,
  };
}