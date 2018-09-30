import 'dart:io';
import 'package:rpc/rpc.dart';
import 'package:mongo_dart/mongo_dart.dart';

final ApiServer _apiServer = new ApiServer();
DbCollection collection;

main() async {
  Db db = Db("mongodb://localhost:27017/local");
  await db.open();
  collection = db.collection("world");
  _apiServer.addApi(new World());
  HttpServer server = await HttpServer.bind('127.0.0.1', 9999);
  server.listen(_apiServer.httpRequestHandler);
}

@ApiClass(version: 'v1')
class World {
  World([collection]);

  @ApiMethod(method: 'GET', path: 'info/{x}/{y}')
  Future<Terrain> getWorldInfo(String x, String y) async {
    var json,
        val = await collection.findOne(
            where.eq("x", int.parse(x)).and(where.eq("y", int.parse(y))));

    json = new Terrain()
      ..name = (val == null ? 'wasteland' : val['terrain'])
      ..x = (val == null ? x : val['x'].toString())
      ..y = (val == null ? y : val['y'].toString());

    return json;
  }
}

class Terrain {
  String name;
  String x;
  String y;
}
