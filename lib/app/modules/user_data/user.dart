import 'package:hive/hive.dart';

part 'user.g.dart'; // Generate Hive adapter using build_runner

@HiveType(typeId: 0) // Unique typeId for Hive
class UserData extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String profileImagePath;

  @HiveField(3)
  final String lastMessage;

  UserData({
    required this.id,
    required this.name,
    required this.profileImagePath,
    required this.lastMessage,
  });
}
