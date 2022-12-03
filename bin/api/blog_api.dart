// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final bool isSecurity;
  final GenericService<NoticiaModel> _service;

  BlogApi(
    this._service, {
    this.isSecurity = false,
  });

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    // listagem...
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();

      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(noticiasMap));
    });

    // nova noticia...
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    // atualizar noticia...
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok("Choveu hoje");
    });

    // atualizar noticia...
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok("Choveu hoje");
    });

    return createHandler(router: router, isSecurity: isSecurity , middlewares: middlewares);
  }
}
