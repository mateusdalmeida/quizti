String getHora(segundos) {
  DateTime date = new DateTime.utc(1, 1, 1, 0, 0, 0);
  date = date.add(Duration(seconds: segundos));
  return date.toString().substring(11, 19);
}

String getData(epoch) {
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(epoch);
  String dateStr = date.toString().substring(0, 16).replaceAll("-", "/");
  String dateAux = dateStr.substring(8, 10);
  dateAux += dateStr.substring(4, 8);
  dateAux += dateStr.substring(0, 4);
  dateAux += dateStr.substring(10);
  return dateAux;
}
