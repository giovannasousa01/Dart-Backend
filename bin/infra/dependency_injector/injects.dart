import '../../../models/noticia_model.dart';
import '../../api/blog_api.dart';
import '../../api/login_api.dart';
import '../../api/usuario_api.dart';
import '../../dao/usuario_dao.dart';
import '../../services/generic_service.dart';
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

    di.register<DBConfigurarion>(() => MySqlDBConfiguration());

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginApi>(() => LoginApi(di<SecurityService>()));

    di.register<GenericService<NoticiaModel>>(() => NoticiaService());

    di.register<BlogApi>(() => BlogApi(di<GenericService<NoticiaModel>>()));

    di.register<UsuarioDAO>(() => UsuarioDAO(di<DBConfigurarion>()));
    di.register<UsuarioService>(() => UsuarioService(di<UsuarioDAO>()));
    di.register<UsuarioApi>(() => UsuarioApi(di<UsuarioService>()));

    return di;
  }
}
