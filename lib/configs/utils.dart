import 'package:intl/intl.dart';

class Utils {
  static String getFormatedDate(DateTime? date) {
    var outputFormat = DateFormat('dd-MM-yyyy');

    if(date != null) {
      return outputFormat.format(date);
    }else{
      return '';
    }
  }
}