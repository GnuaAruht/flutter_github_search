part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Repo> repos;

  SearchSuccessState(this.repos);
}

class SearchFailedState extends SearchState {
  final String messgae;

  SearchFailedState(this.messgae);
}
