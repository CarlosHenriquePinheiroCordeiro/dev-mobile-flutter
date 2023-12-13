class LocalizacaoModel {
  final int id;
  final String nome;
  final String coordenadas;

  LocalizacaoModel({required this.id, required this.nome, required this.coordenadas});

  factory LocalizacaoModel.fromJson(Map<String, dynamic> aJson) {
    return LocalizacaoModel(
      id: aJson['id'] as int,
      nome: aJson['nome'] as String,
      coordenadas: aJson['coordenadas'] as String,
    );
  }
}
