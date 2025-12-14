import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../cubits/assessment_cubit.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultScreen({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prediction = result['prediction']?.toString() ?? 'Unknown';
    final needsTreatment =
        prediction.toLowerCase() == 'yes' ||
        prediction == '1' ||
        prediction == 'true';

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.cardBackground,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Result Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: needsTreatment
                              ? AppColors.warning.withOpacity(0.1)
                              : AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: needsTreatment
                                ? AppColors.warning
                                : AppColors.success,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Icon(
                            //   needsTreatment
                            //       ? Icons.health_and_safety
                            //       : Icons.check_circle,
                            //   size: 80,
                            //   color: needsTreatment
                            //       ? AppColors.warning
                            //       : AppColors.success,
                            // ),
                            // const SizedBox(height: 16),
                            Text(
                              needsTreatment
                                  ? 'Consider Seeking Support'
                                  : 'Low Risk Indicated',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardBackground,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              needsTreatment
                                  ? 'Based on your responses, seeking professional mental health support may be beneficial.'
                                  : 'Your responses suggest a lower likelihood of needing mental health treatment at this time.',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.cardBackground,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Important Disclaimer
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.error.withOpacity(0.3),
                          ),
                        ),
                        child: Expanded(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Important Disclaimer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.error,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This is NOT a medical diagnosis. This tool provides general guidance based on workplace mental health research. Please consult a qualified mental health professional for proper evaluation and treatment.',
                                style: TextStyle(
                                  color: AppColors.cardBackground,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // What to do next
                      Text(
                        'What to do next?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.cardBackground,
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (needsTreatment) ...[
                        _buildActionCard(
                          icon: Icons.medical_services,
                          title: 'Speak with a Professional',
                          description:
                              'Consider scheduling an appointment with a therapist, counselor, or psychiatrist.',
                          //  color: AppColors.warning,
                        ),
                        const SizedBox(height: 12),
                        _buildActionCard(
                          icon: Icons.business,
                          title: 'Check Your Benefits',
                          description:
                              'Review your employer\'s mental health benefits and Employee Assistance Program (EAP).',
                          // color: AppColors.secondary,
                        ),
                      ] else ...[
                        _buildActionCard(
                          icon: Icons.self_improvement,
                          title: 'Maintain Good Habits',
                          description:
                              'Continue practicing self-care, exercise, and stress management.',
                          //  color: AppColors.success,
                        ),
                        const SizedBox(height: 12),
                        _buildActionCard(
                          icon: Icons.visibility,
                          title: 'Stay Aware',
                          description:
                              'Monitor your mental health and don\'t hesitate to seek help if things change.',
                          // color: AppColors.secondary,
                        ),
                      ],

                      const SizedBox(height: 12),
                      _buildActionCard(
                        icon: Icons.book,
                        title: 'Access Resources',
                        description:
                            'View our curated list of mental health resources and crisis hotlines.',
                        //  color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Back to home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cardBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.warning, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff261403),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Color(0xff261403), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
