import '../../../models/noticia_model.dart';
import '../../api/noticias_api.dart';
import '../../api/login_api.dart';
import '../../api/usuario_api.dart';
import '../../dao/noticia_dao.dart';
import '../../dao/usuario_dao.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/noticia_service.dart';
import '../../services/usuario_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    // Injeções de Banco de Dados
    di.register<DBConfigurarion>(() => MySqlDBConfiguration());

    // Injeções de segurança
    di.register<SecurityService>(() => SecurityServiceImp());

    //Injeções de notícias
    di.register<NoticiaDAO>(() => NoticiaDAO(di<DBConfigurarion>()));
    di.register<GenericService<NoticiaModel>>(
        () => NoticiaService(di<NoticiaDAO>()));
    di.register<NoticiasApi>(
        () => NoticiasApi(di<GenericService<NoticiaModel>>()));

    //Injeções de usuário
    di.register<UsuarioDAO>(() => UsuarioDAO(di<DBConfigurarion>()));
    di.register<UsuarioService>(() => UsuarioService(di<UsuarioDAO>()));
    di.register<UsuarioApi>(() => UsuarioApi(di<UsuarioService>()));

    //Injeções de Login
    di.register<LoginService>(() => LoginService(di<UsuarioService>()));
    di.register<LoginApi>(() => LoginApi(
          di<SecurityService>(),
          di<LoginService>(),
        ));

    return di;
  }
}
