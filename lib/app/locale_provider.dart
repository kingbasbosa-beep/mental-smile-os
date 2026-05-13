import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// null = no stored user choice yet; the app falls back to Arabic.
final localeProvider = StateProvider<Locale?>((ref) => null);
