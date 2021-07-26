import 'dart:math';

int generateID() {
  int id;
  id = DateTime.now().millisecondsSinceEpoch + random(100, 999);
  return id;
}

random(min, max) {
  var rn = new Random();
  return min + rn.nextInt(max - min);
}
