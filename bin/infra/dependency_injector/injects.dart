import '../../../models/noticia_model.dart';
import '../../api/blog_api.dart';
import '../../api/login_api.dart';
import '../../services/generic_service.dart';
import '../../services/noticia_service.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginApi>(() => LoginApi(di()));

    di.register<GenericService<NoticiaModel>>(() => NoticiaService());

    di.register<BlogApi>(() => BlogApi(di()));

    return di;
  }
}
