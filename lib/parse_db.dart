import 'dart:convert';
import 'dart:io';

void main() {
  final file = File(
      'E:\\1_flutter\\Мое приложение\\Базы данных продуктов\\en.openfoodfacts.org.products.csv');
  Stream<List<int>> inputStream = file.openRead();
  int i = 0;
  int counter = 0;
  List a = List.filled(203, 0);
  inputStream
      .transform(utf8.decoder)
      .transform(
        const LineSplitter(),
      )
      .listen(
          (String line) {

            counter++;
            // print(
            //     '=========================================================================================================');
            // print('Строка $counter: $line');
            var k = line.length;
            // print('Подстрока между 0 и 20 символами: ${line.substring(0, 21)}');
            var i1 = 0;
            var k1 = 0;
            // print('Очередная строка содержит $k символов');
            for (var i = 0; i < k; i++) {
              // print(
              //     'Смотрим какой символ обрабатывается $i -й символ = ${line[i]}');
              if (line[i] == '\t') {
                var l = line.substring(i1, i).length;
                // print(
                //     'Подстрока между знаками табуляции: ${line.substring(i1, i)} её длина равна $l');
                if (l > 0) {
                  var an = a[k1] + 1;
                  // print('************** an = $an');
                  // print('************** k1 = $k1 a[k1] = ${a[k1]}');
                  // print('************** a = $a');
                  a[k1]++;
                  i1 = i + 1;
                }
                k1 = k1 + 1;
              }

            }
          },
          onDone: () { print(' СПИСОК aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $a');},
          onError: (e) {
            print(e);
          });
}
