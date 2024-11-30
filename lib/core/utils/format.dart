import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatTimeAgo(DateTime? date) {
  timeago.setLocaleMessages('id', timeago.IdMessages());
  return timeago.format(date ?? DateTime.now(), locale: 'id');
}

String formatDate(DateTime? date) {
  initializeDateFormatting('id_ID', null);
  return DateFormat('EEEE, d MMMM y', 'id_ID').format(date ?? DateTime.now());
}
