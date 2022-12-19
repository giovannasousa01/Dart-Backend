abstract class DAO<T> {
  //CRUD

  Future<bool> create(T value);
  Future<T?> findOne(int id);
  Future<List<T>> findAll();
  Future<bool> delete(int id);
  Future<bool> update(T value);
}
