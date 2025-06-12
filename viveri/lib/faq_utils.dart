import 'package:timeago/timeago.dart' as timeago;

void configurarTimeago() {
  timeago.setLocaleMessages('pt', timeago.PtBrMessages());
}

String tempoRelativo(DateTime data) {
  return timeago.format(data, locale: 'pt');
}
