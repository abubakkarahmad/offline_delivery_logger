import 'package:intl/intl.dart';

class DateFormats {
  static final utc = DateFormat("yyyy-MM-dd HH:mm:ss 'UTC'");
  static String formatUtc(DateTime dt) => utc.format(dt.toUtc());
}
