class User{
  final String userId;
  final String fullName;
  final String email;

  User(this.userId, this.fullName, this.email);
  
  static User fromJson(Map<String,dynamic> data){
     
    return User(data['userId'], data['fullName'], data['email']);
  }

}