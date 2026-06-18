import 'signal_aggregate.dart';

class MostRequestedGoals {
  const MostRequestedGoals({required this.items});

  final List<SignalAggregate> items;
}

class MostContactedProviderCategories {
  const MostContactedProviderCategories({required this.items});

  final List<SignalAggregate> items;
}

class MostOpenedLibraryTopics {
  const MostOpenedLibraryTopics({required this.items});

  final List<SignalAggregate> items;
}
