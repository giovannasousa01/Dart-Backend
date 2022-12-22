import '../../models/noticia_model.dart';
import '../infra/database/db_configuration.dart';
import 'dao.dart';

class NoticiaDAO implements DAO<NoticiaModel> {
  final DBConfigurarion _dbConfigurarion;

  NoticiaDAO(this._dbConfigurarion);

  @override
  Future<bool> create(NoticiaModel value) async {
    var result = await _dbConfigurarion.execQuery(
      'INSERT INTO noticias(titulo, descricao, id_usuario) VALUES (?, ?, ?)',
      [value.title, value.description, value.userId],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfigurarion.execQuery(
      'DELETE FROM noticias WHERE id = ?',
      [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<NoticiaModel>> findAll() async {
    var result = await _dbConfigurarion.execQuery('SELECT * FROM noticias');

    return result
        .map((r) => NoticiaModel.fromMap(r.fields))
        .toList()
        .cast<NoticiaModel>();
  }

  @override
  Future<NoticiaModel?> findOne(int id) async {
    var result = await _dbConfigurarion.execQuery(
      'SELECT * FROM noticias WHERE id = ?',
      [id],
    );

    return result.isEmpty
        ? null
        : NoticiaModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NoticiaModel value) async {
    var result = await _dbConfigurarion.execQuery(
      'UPDATE noticias SET titulo = ?, descricao = ? WHERE id = ?',
      [value.title, value.description, value.id],
    );
    return result.affectedRows > 0;
  }
}
