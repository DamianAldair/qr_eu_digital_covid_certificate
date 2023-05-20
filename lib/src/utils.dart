Map<K, V> toMap<K, V>(Map<dynamic, dynamic> source) {
  final Map<K, V> map = {};
  for (int i = 0; i < source.entries.length; i++) {
    final key = source.keys.toList()[i] as K;
    final value = source.values.toList()[i] as V;
    map.addEntries(<K, V>{key: value}.entries);
  }
  return map;
}
