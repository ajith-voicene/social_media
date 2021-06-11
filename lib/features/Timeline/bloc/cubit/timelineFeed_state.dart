part of 'timelineFeed_cubit.dart';

abstract class TimelineFeedState extends Equatable {
  const TimelineFeedState();

  @override
  List<Object> get props => [];
}

class TimelineFeedInitial extends TimelineFeedState {}

class TimelineFeedLoading extends TimelineFeedState {}

class TimelineFeedSuccess extends TimelineFeedState {
  final List<Data> list;

  TimelineFeedSuccess(this.list);
  @override
  List<Object> get props => [this.list];
}

class TimelineFeedError extends TimelineFeedState {
  final Failure error;

  TimelineFeedError(this.error);
  @override
  List<Object> get props => [this.error];
}
