import 'dart:async';
import 'dart:math';

test() async {
  int result = await Future.delayed(Duration(seconds: 3), () {
    return Future.value(123);
  });
  print('t3:' + DateTime.now().toString());
  print(result);
}

void main() {
  // future
  // print('t1:'+DateTime.now().toString());
  // test();
  // print('t2:'+DateTime.now().toString());

  // future.whenComplete
  var random = Random();
  Future.delayed(const Duration(seconds: 3), () {
    if (random.nextBool()) {
      return 100;
    } else {
      throw 'boom!';
    }
  }).timeout(Duration(seconds: 2)).then(print).catchError(print).whenComplete(() => print('done!'));
}
