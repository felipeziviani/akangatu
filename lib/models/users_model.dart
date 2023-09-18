class UserProfileBrowse {
  String userId;
  String name;
  String email;
  String senha;

  UserProfileBrowse(
    this.userId,
    this.name,
    this.email,
    this.senha,
  );

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'userId': userId,
        'name': name,
        'email': email,
        'senha' : senha,
      };
}