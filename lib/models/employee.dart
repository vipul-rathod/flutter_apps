class Employee {
  // final int id;
  final String name;
  final String dob;
  final String phone;
  final String  qualification;
  final String gender;
  // final String date;

  static final columns = ['id', 'name', 'dob', 'phone', 'qualification', 'gender', 'date'];

  Employee(this.name, this.dob, this.phone, this.qualification, this.gender);

  factory Employee.fromMap(Map<String, dynamic> data){
    return Employee(
      // data['id'],
      data['name'],
      data['dob'],
      data['phone'],
      data['qualification'],
      data['gender'],
      // data['date'],
    );
  }

  Map<String, dynamic> toMap() => {
    // 'id' : id,
    'name' : name,
    'dob' : dob,
    'phone' : phone,
    'qualification' : qualification,
    'gender' : gender,
    // 'date' : date,
  };
}