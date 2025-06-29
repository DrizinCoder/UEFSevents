import 'package:timeago/timeago.dart' as timeago;

void configurarTimeago() {
  timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
}

String tempoRelativo(DateTime data) {
  return timeago.format(data, locale: 'pt_br');
}
