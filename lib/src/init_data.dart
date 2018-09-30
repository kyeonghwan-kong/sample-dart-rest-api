import 'dart:math';
import 'package:mongo_dart/mongo_dart.dart';

main() async {
  print("go for it ...");
  Db db = new Db("mongodb://localhost:27017/local");
  await db.open();
  await db.drop();
  print("database is open");
  var collection = db.collection("world");
  var userCollection = db.collection("users");

  List<Map<String, dynamic>> playground = new List();
  var _rng = new Random();

  for (var x = 0; x < 10; x++) {
    for (var y = 0; y < 10; y++) {
      var value = _rng.nextInt(5);
      if (value == 3) {
        playground.add({'x': x, 'y': y, 'terrain': 'tree'});
      } else {
        playground.add({'x': x, 'y': y, 'terrain': 'grass'});
      }
      print("coordiante ${x} ${y}");
    }
  }
  print("put them into a collection");
  await collection.insertAll(playground);
  await userCollection.insertAll([
    {
      'name': 'William Shakespeare',
      'email': 'william@shakespere.com',
      'age': 587
    },
    {'name': 'Jorge Luis Borges', 'email': 'jorge@borges.com', 'age': 123}
  ]);
  print("done!");
  await db.close();
}
