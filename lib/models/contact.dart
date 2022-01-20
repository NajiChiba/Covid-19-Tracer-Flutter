import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  @Id()
  int id;

  String? udid;

  String? token;

  Contact({required this.id, this.udid, this.token});
}
