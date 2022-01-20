import 'package:objectbox/objectbox.dart';

@Entity()
class QrCode {
  @Id()
  int id;

  String? content;

  String? type;

  bool? pcr;

  @Property(type: PropertyType.date)
  DateTime date;

  QrCode(
      {this.content,
      this.pcr,
      required this.date,
      this.type,
      required this.id});
}
