part of 'downloadfile_cubit.dart';

abstract class DownloadfileState extends Equatable {
  const DownloadfileState();

  @override
  List<Object> get props => [];
}

class DownloadfileInitial extends DownloadfileState {}

class DownloadfileError extends DownloadfileState {
  final Failure error;

  DownloadfileError(this.error);
  @override
  List<Object> get props => [this.error];
}

class DownloadfileSuccess extends DownloadfileState {
  final File file;

  DownloadfileSuccess(this.file);
  @override
  List<Object> get props => [this.file];
}
