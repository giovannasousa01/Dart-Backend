// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';
import 'package:mysql1/mysql1.dart';

void main() async {
  var conexao = await MySqlConnection.connect(
    ConnectionSettings(
      host: await CustomEnv.get<String>(key: 'db_host'),
      port: await CustomEnv.get<int>(key: 'db_port'),
      user: await CustomEnv.get<String>(key: 'db_user'),
      password: await CustomEnv.get<String>(key: 'db_pass'),
      db: await CustomEnv.get<String>(key: 'db_schema'),
    ),
  );

  var result = await conexao.query('SELECT * FROM usuarios;');
  print(result);

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
