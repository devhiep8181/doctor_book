import 'dart:developer';

import 'package:intl/intl.dart';

class ProcessDatetime {
  static String formatDateToMonthYear(DateTime inputDateTime) {
    // Lấy tháng và năm từ đối tượng DateTime
    int month = inputDateTime.month;
    int year = inputDateTime.year;

    // Trả về chuỗi theo định dạng "Tháng X/Năm"
    return "Tháng $month/$year";
  }

  static String formatDateTime(DateTime dateTime) {
    // Định dạng theo dạng HH:mm:ss dd/MM/yyyy
    final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static String formatDate(DateTime inputDateTime) {
    // Lấy tháng và năm từ đối tượng DateTime
    int month = inputDateTime.month;
    int year = inputDateTime.year;
    int day = inputDateTime.day;

    String formattedDay = day < 10 ? '0$day' : '$day';
    String formattedMonth = month < 10 ? '0$month' : '$month';

    return "$formattedDay/$formattedMonth/$year";
  }




  static int amountDayInMonth(DateTime inputDateTime) {
    int month = inputDateTime.month;
    int year = inputDateTime.year;

    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        if ((year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
          return 29;
        } else {
          return 28;
        }
      default:
        return 30;
    }
  }

  static String dayOfWeekToString(DateTime inputDateTime) {
    int dayOfWeek = inputDateTime.weekday;
    switch (dayOfWeek) {
      case DateTime.monday:
        return "T2";
      case DateTime.tuesday:
        return "T3";
      case DateTime.wednesday:
        return "T4";
      case DateTime.thursday:
        return "T5";
      case DateTime.friday:
        return "T6";
      case DateTime.saturday:
        return "T7";
      case DateTime.sunday:
        return "CN";
      default:
        return "";
    }
  }

  static List<String> generateShifts(
      String startTime, String endTime, Duration interval) {
    List<String> shifts = [];

    DateFormat format = DateFormat('HH:mm');
    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);

    DateTime current = start;

    while (current.isBefore(end)) {
      DateTime next = current.add(interval);
      if (next.isAfter(end)) {
        next = end; // Đảm bảo không vượt quá giờ kết thúc
      }

      String shift = '${format.format(current)} - ${format.format(next)}';
      log('SHIFT =================> $shift');
      shifts.add(shift);

      current = next;
    }

    return shifts;
  }
}
