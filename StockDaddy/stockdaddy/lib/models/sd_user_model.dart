import 'package:equatable/equatable.dart';

class SDUserModel extends Equatable {
  const SDUserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;
  final String uid;

  @override
  List<Object?> get props => [
        name,
        email,
        uid,
      ];
}
