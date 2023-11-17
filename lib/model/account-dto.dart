class AccountDTO {
  final String email;
  final String password;
  AccountDTO({required this.email, required this.password});
  AccountDTO copyWith({String ?email, String? password}) {
    // TODO: implement copyWith
    return AccountDTO(
      email: email ?? this.email, 
      password: password ?? this.password);
  }
  @override
  bool operator == (Object other)=>
     identical(this, other) ||
      other is AccountDTO && runtimeType == other.runtimeType && 
      password == other.password && email == other.email;
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}