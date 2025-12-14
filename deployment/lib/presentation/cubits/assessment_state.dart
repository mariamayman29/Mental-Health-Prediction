import 'package:equatable/equatable.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentSuccess extends AssessmentState {
  final Map<String, dynamic> result;

  const AssessmentSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object?> get props => [message];
}
