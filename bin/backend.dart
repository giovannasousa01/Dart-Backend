// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'package:shelf/shelf.dart';

import '../models/usuario_model.dart';
import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'dao/usuario_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  final _di = Injects.initialize();

  UsuarioDAO _usuarioDAO = UsuarioDAO(_di<DBConfigurarion>());

  var usuario = UsuarioModel()
    ..id = 13
    ..name = 'Tyler J'
    ..email = 'tyler@email.com'
    ..password = 'abc45';

  // _usuarioDAO.create(usuario).then(print);
  // _usuarioDAO.findAll().then(print);
  // _usuarioDAO.findOne(13).then(print);
  // _usuarioDAO.update(usuario).then(print);
  // _usuarioDAO.delete(12).then(print);

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
