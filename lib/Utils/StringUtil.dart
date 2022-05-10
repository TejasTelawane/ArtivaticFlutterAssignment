import 'package:intl/intl.dart';

class StringUtil {
  static bool isNull(String? val) {
    if (val == null ||
        val.isEmpty ||
        val.trim().isEmpty ||
        val.trim() == "" ||
        val.trim() == "null") return true;

    return false;
  }

  static bool isNullObject(Object? val) {
    if (val == null) return true;

    return false;
  }

  static bool isNullList(List? val) {
    if (val == null || val.isEmpty) return true;

    return false;
  }

  static bool CheckEqualIgnoreCase(String? str1, String? str2) {
    if (!isNull(str1) &&
        !isNull(str2) &&
        str1!.toUpperCase() == str2!.toUpperCase()) {
      return true;
    }
    return false;
  }

  static bool CheckEqualCaseSensitive(String? str1, String? str2) {
    if (!isNull(str1) && !isNull(str2) && str1 == str2) {
      return true;
    }
    return false;
  }

  static bool CheckifStringContains(String? mainString, String? StrToCheck) {
    if (!isNull(mainString) &&
        !isNull(StrToCheck) &&
        mainString!.toUpperCase().contains(StrToCheck!.toUpperCase())) {
      return true;
    }
    return false;
  }

  static String replaceAllSpecialCharecters(String? str) {
    String newStr = '';
    if (!isNull(str)) {
      newStr = str!.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    }

    return newStr;
  }

  static String ConvertNumbertoWords(int number) {
    if (number == 0) return "ZERO";
    if (number < 0) {
      return "minus " + ConvertNumbertoWords(number.abs());
    }
    String words = "";

    if ((number / 1000000000) > 0) {
      int temp = (number / 1000000000) as int;
      words += ConvertNumbertoWords(temp) + " BILLION ";
      number %= 1000000000;
    }

    if ((number / 10000000) > 0) {
      int temp = (number / 10000000) as int;
      words += ConvertNumbertoWords(temp) + " CRORE ";
      number %= 10000000;
    }

    if ((number / 100000) > 0) {
      int temp = (number / 100000) as int;
      words += ConvertNumbertoWords(temp) + " LAKH ";
      number %= 100000;
    }

    if ((number / 1000) > 0) {
      int temp = (number / 1000) as int;
      words += ConvertNumbertoWords(temp) + " THOUSAND ";
      number %= 1000;
    }
    if ((number / 100) > 0) {
      int temp = (number / 100) as int;
      words += ConvertNumbertoWords(temp) + " HUNDRED ";
      number %= 100;
    }
    if (number > 0) {
      if (words != "") {
        words += "AND ";
      }
      List<String> unitsMap = [
        "ZERO",
        "ONE",
        "TWO",
        "THREE",
        "FOUR",
        "FIVE",
        "SIX",
        "SEVEN",
        "EIGHT",
        "NINE",
        "TEN",
        "ELEVEN",
        "TWELVE",
        "THIRTEEN",
        "FOURTEEN",
        "FIFTEEN",
        "SIXTEEN",
        "SEVENTEEN",
        "EIGHTEEN",
        "NINETEEN"
      ];
      List<String> tensMap = [
        "ZERO",
        "TEN",
        "TWENTY",
        "THIRTY",
        "FORTY",
        "FIFTY",
        "SIXTY",
        "SEVENTY",
        "EIGHTY",
        "NINETY"
      ];

      if (number < 20)
        words += unitsMap[number];
      else {
        int temp = (number / 10) as int;
        words += tensMap[temp];
        if ((number % 10) > 0) {
          words += " " + unitsMap[number % 10];
        }
      }
    }
    return words;
  }

  static String GetAmountInIndianCurrency(int amount) {
    String amountInIndiaCurrency = "0";

    try {
      var format = NumberFormat.currency(locale: 'HI');
      amountInIndiaCurrency = format.format(amount);
    } catch (e) {
      print(e);
    }
    return amountInIndiaCurrency;
  }
}
