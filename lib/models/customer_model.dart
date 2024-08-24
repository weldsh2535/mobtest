


class User {
  final String firstname;
  final String lastname;
  final String? phone;
  final String? address;
  final String? email;

  User({
    required this.firstname,
    required this.lastname,
    this.phone,
    this.address,
    this.email,
  });

factory User.fromJson(Map<String, dynamic> json) => User(
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: (json['phone'] != null) ? json['phone'] : null,
      email: (json['email'] != null) ? json["email"] : null,
      address: (json['address'] != null) ? json["address"] : null);
}


class CustomerModel {
  final int currentPage;
  final List<User> user;
  final String? nextPageUrl;
  final String path;
  final String? prevPageUrl;
  final int total;

  CustomerModel({
    required this.currentPage,
    required this.user,
    this.nextPageUrl,
    required this.path,
    this.prevPageUrl,
    required this.total,
  });

factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      currentPage: json['current_page'],
      user:  List<User>.from(json['data'].map((x) => User.fromJson(x))),
      nextPageUrl: (json['next_page_url'] != null) ? json["next_page_url"] : null,
      path: json["path"],
      prevPageUrl: (json['prev_page_url'] != null) ? json["prev_page_url"] : null,
      total: json['total']);
}


