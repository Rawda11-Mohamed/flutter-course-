abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final String languageCode;
  LanguageLoaded({required this.languageCode});
}

class LanguageError extends LanguageState {
  final String message;
  LanguageError(this.message);
}