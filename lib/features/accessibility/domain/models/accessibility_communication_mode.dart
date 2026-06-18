enum AccessibilityCommunicationMode {
  standard('standard'),
  simplified('simplified'),
  accessibility('accessibility'),
  deafMode('deaf_mode'),
  blindMode('blind_mode'),
  easyLanguage('easy_language');

  const AccessibilityCommunicationMode(this.value);

  final String value;

  static const List<AccessibilityCommunicationMode> v1Allowed =
      <AccessibilityCommunicationMode>[
    standard,
    simplified,
    accessibility,
  ];

  static const List<AccessibilityCommunicationMode> futureValues =
      <AccessibilityCommunicationMode>[
    deafMode,
    blindMode,
    easyLanguage,
  ];
}
