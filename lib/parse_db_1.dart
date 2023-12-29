import 'dart:collection';
import 'dart:convert';
import 'dart:io';

void main() {
  final file = File(
      'E:\\1_flutter\\Мое приложение\\Базы данных продуктов\\en.openfoodfacts.org.products.csv');
  Stream<List<int>> inputStream = file.openRead();
  int i = 0;
  int counter = 0;
  // List<String> keys;
  List keys = List.filled(203, '0');
  List a = List.filled(203, 0);
  inputStream
      .transform(utf8.decoder)
      .transform(
        const LineSplitter(),
      )
      .listen((String line) {
    if (counter == 0) {
      keys = line.split('\t');
      // print('*********** ${keys.length}');
      // print('*********** $keys');
    }

    counter++;
    var k = line.length;
    var i1 = 0;
    var k1 = 0;
    for (var i = 0; i < k; i++) {
      if (line[i] == '\t') {
        var l = line.substring(i1, i).length;
        if (l > 0) {
          a[k1]++;
          i1 = i + 1;
        }
        k1 = k1 + 1;
      }
    }
  }, onDone: () {
    // print(' СПИСОК a = $a');

    List<int> values = [...a];
    // print(' =================   ${keys.length}  ${values.length}');
    Map<dynamic, dynamic> unsortedMap = Map.fromIterables(keys, values);

    var sortedKeys = unsortedMap.keys.toList(growable: false)
      ..sort((k1, k2) {
        int cmp = unsortedMap[k2]!.compareTo(unsortedMap[k1]!);
        if (cmp != 0) {
          return cmp;
        } else {
          return k1.compareTo(k2); // Дополнительная сортировка по алфавиту
        }
      });

    LinkedHashMap sortedMap = LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => unsortedMap[k]);
    print('Исходная карта: $unsortedMap');
    print('');
    print('Отсортированная карта: $sortedMap');
  }, onError: (e) {
    print(e);
  });
}


