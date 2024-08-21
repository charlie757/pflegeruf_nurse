import 'package:intl/intl.dart';

class TimeFormat {
  static String convertBookingDate(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(myDateTime));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    // String roughTimeString = DateFormat('jm').format(dateTime);
    return '${DateFormat('dd MMM yyyy').format(dateTime)}';
  }

  static String convertBookingTime(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(myDateTime));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    // String roughTimeString = DateFormat('jm').format(dateTime);
    return DateFormat('HH:mm').format(dateTime);
  }

  static String convertReviewDate(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(myDateTime));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    // String roughTimeString = DateFormat('jm').format(dateTime);
    return '${DateFormat('MMM dd, yyyy').format(dateTime)}';
  }

  static String convertNotificationDate(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(myDateTime));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();
    String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return '$formattedDate at $formattedTime';
  }
}
