import 'package:intl/intl.dart';

mixin ChallengeItem {
  static DateFormat _internalFormat = DateFormat("yyyy-MM-dd");
  static DateFormat _externalFormat = DateFormat("MMMM d, y");

  String get name;
  String get description;
  DateTime get date;

  String get dateString {
    return _internalFormat.format(date);
  }

  String get formattedDate {
    return _externalFormat.format(date);
  }
}