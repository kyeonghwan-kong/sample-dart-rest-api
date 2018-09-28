import 'dart:io';
import 'package:rpc/rpc.dart';

final ApiServer _apiServer = new ApiServer();

main() async {
  _apiServer.addApi(new World());
  HttpServer server = await HttpServer.bind('127.0.0.1', 8082);
  server.listen(_apiServer.httpRequestHandler);
}

@ApiClass(version: 'v1')
class World {
  @ApiMethod(method: 'GET', path: 'world/{x}/{y}')
  Terrain getWorldInfo(String x, String y){
    return new Terrain()
        ..name = "grass"
        ..x = x
        ..y = y;
  }
}

class Terrain {
  String name;
  String x;
  String y;
}
