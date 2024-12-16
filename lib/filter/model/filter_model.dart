class FilterModel {
  final String name;
  final String? backgroundImage;
  final List<int> generations;
  final List<String> types;
  final int? captureRate;
  final bool? isLegendary;

  const FilterModel({
    required this.name,
    this.backgroundImage,
    this.generations = const [],
    this.types = const [],
    this.captureRate,
    this.isLegendary,
  });
}