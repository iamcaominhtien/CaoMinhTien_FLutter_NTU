// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyContact {
  final String name, phone;
  final String? email;
  MyContact({
    required this.name,
    required this.phone,
    this.email,
  });
}
