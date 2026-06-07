class CommercialMeterMapping {
  const CommercialMeterMapping({
    required this.commercialDimension,
    required this.meterDimension,
    required this.description,
  });

  final String commercialDimension;
  final String meterDimension;
  final String description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'commercialDimension': commercialDimension,
      'meterDimension': meterDimension,
      'description': description,
    };
  }
}
