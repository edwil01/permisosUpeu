import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Format{
  static String toMonthDayDate(DateTime date){
   return DateFormat('dd/MM').add_jm().format(date);
  }
}