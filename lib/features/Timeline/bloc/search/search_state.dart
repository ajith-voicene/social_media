part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<User> users;

  SearchSuccess(this.users);

  @override
  List<Object> get props => [this.users];
}

class SearchError extends SearchState {
  final Failure error;

  SearchError(this.error);

  @override
  List<Object> get props => [this.error];
}
