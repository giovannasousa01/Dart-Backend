// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import '../../models/usuario_model.dart';
import '../infra/database/db_configuration.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UsuarioModel> {
  final DBConfigurarion _dbConfigurarion;
  UsuarioDAO(this._dbConfigurarion);

  @override
  Future<bool> create(UsuarioModel value) async {
    var result = await _dbConfigurarion.execQuery(
      'INSERT INTO usuarios(nome, email, password) VALUES (?, ?, ?)',
      [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfigurarion.execQuery(
      'DELETE FROM usuarios WHERE id = ?',
      [id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    var result = await _dbConfigurarion.execQuery('SELECT * FROM usuarios');

    return result
        .map((r) => UsuarioModel.fromMap(r.fields))
        .toList()
        .cast<UsuarioModel>();
  }

  @override
  Future<UsuarioModel?> findOne(int id) async {
    var result = await _dbConfigurarion.execQuery(
      'SELECT * FROM usuarios WHERE id = ?',
      [id],
    );

    return result.affectedRows == 0
        ? null
        : UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UsuarioModel value) async {
    var result = await _dbConfigurarion.execQuery(
      'UPDATE usuarios SET nome = ?, password = ? WHERE id = ?',
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  Future<UsuarioModel?> findByEmail(String email) async {
    var result =
        await _dbConfigurarion.execQuery('SELECT * FROM usuarios WHERE email = ?', [email]);
    return result.affectedRows == 0
        ? null
        : UsuarioModel.fromEmail(result.first.fields);
  }


}
