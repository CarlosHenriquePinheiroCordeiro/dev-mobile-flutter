class LocalizacaoModel {
  final int id;
  final String nome;
  final String coordenadas;

  LocalizacaoModel({required this.id, required this.nome, required this.coordenadas});

  factory LocalizacaoModel.fromJson(Map<String, dynamic> json) {
    return LocalizacaoModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      coordenadas: json['coordenadas'] as String,
    );
  }
}
