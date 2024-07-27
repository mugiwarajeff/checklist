class CreateItemException implements Exception {
  String error;

  CreateItemException({required this.error});
}
