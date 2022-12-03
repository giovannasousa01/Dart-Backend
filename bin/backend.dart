// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp());

  var _securityService = _di.get<SecurityServiceImp>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler(middlewares: [
        createMiddleware(requestHandler: (Request req) {
          print('LOG -> ${req.url}');
        })
      ]))
      .add(
        BlogApi(NoticiaService()).getHandler(middlewares: [
          _securityService.auhtorization,
          _securityService.verifyJwt,
        ]),
      )
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
