import 'package:eunoia/data/services/api_services.dart';

import '../models/user_input_model.dart';

class MentalHealthRepository {
  final ApiService apiService;

  MentalHealthRepository({required this.apiService});

  Future<Map<String, dynamic>> getPrediction(UserInputModel input) async {
    try {
      final response = await apiService.predict(input.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
