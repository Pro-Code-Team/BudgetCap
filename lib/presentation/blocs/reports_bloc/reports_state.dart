part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  final int currentPage;
  const ReportsState({this.currentPage = 0});

  ReportsState copyWith({int? currentPage}) {
    return ReportsState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [currentPage];
}
