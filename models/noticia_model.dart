class NoticiaModel {
  final int? id;
  final String titulo;
  final String description;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtualizacao;

  NoticiaModel(
    this.id,
    this.titulo,
    this.description,
    this.imagem,
    this.dtPublicacao,
    this.dtAtualizacao,
  );

  factory NoticiaModel.fromJson(Map map) {
    return NoticiaModel(
      map['id'] ?? '',
      map['titulo'],
      map['description'],
      map['imagem'],
      DateTime.fromMillisecondsSinceEpoch(map['dtPublicacao']),
      map['dtAtualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtAtualizacao'])
          : null,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': description,
      'imagem': imagem
    };
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, description: $description, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtualizacao: $dtAtualizacao)';
  }
}
