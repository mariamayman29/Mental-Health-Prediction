import 'package:eunoia/data/repositories/mental_health_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_input_model.dart';
import 'assessment_state.dart';

class AssessmentCubit extends Cubit<AssessmentState> {
  final MentalHealthRepository repository;

  // Store form data
  Map<String, dynamic> formData = {};

  AssessmentCubit({required this.repository}) : super(AssessmentInitial());

  void updateFormData(Map<String, dynamic> data) {
    formData.addAll(data);
  }

  Future<void> submitAssessment(UserInputModel input) async {
    emit(AssessmentLoading());

    try {
      final result = await repository.getPrediction(input);
      emit(AssessmentSuccess(result));
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  void reset() {
    formData.clear();
    emit(AssessmentInitial());
  }
}
