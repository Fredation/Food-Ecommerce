import 'package:intl/intl.dart';

String formatMoney({required num amount, String? symbol}) {
  final format = NumberFormat.currency(
      locale: "en_US", symbol: (symbol == null ? "" : "$symbol "));
  return format.format(amount);
}
