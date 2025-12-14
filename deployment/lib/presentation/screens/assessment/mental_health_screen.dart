import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/user_input_model.dart';
import '../../cubits/assessment_cubit.dart';
import '../../cubits/assessment_state.dart';
import '../../widgets/custom_dropdown.dart';
import '../result_screen.dart';

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({Key? key}) : super(key: key);

  @override
  State<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends State<MentalHealthScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _familyHistory;
  String? _workInterfere;
  String? _leave;
  String? _mentalHealthConsequence;
  String? _physHealthConsequence;
  String? _coworkers;
  String? _supervisor;
  String? _mentalHealthInterview;
  String? _physHealthInterview;
  String? _mentalVsPhysical;
  String? _obsConsequence;

  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> interfereOptions = [
    'Never',
    'Rarely',
    'Sometimes',
    'Often',
  ];
  final List<String> leaveOptions = [
    'Very easy',
    'Somewhat easy',
    'Somewhat difficult',
    'Very difficult',
  ];
  final List<String> coworkerOptions = ['Yes', 'No', 'Some of them'];
  final List<String> maybeOptions = ['Yes', 'No', 'Maybe'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white),
      body: BlocListener<AssessmentCubit, AssessmentState>(
        listener: (context, state) {
          if (state is AssessmentSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(result: state.result),
              ),
            );
          } else if (state is AssessmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Mental health awareness',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Final questions about mental health in your workplace',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 32),

                        CustomDropdown(
                          label:
                              'Do you have a family history of mental illness?',
                          value: _familyHistory,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _familyHistory = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label: 'Does work interfere with your mental health?',
                          value: _workInterfere,
                          items: interfereOptions,
                          onChanged: (value) =>
                              setState(() => _workInterfere = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label: 'How easy is it to take medical leave?',
                          value: _leave,
                          items: leaveOptions,
                          onChanged: (value) => setState(() => _leave = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would discussing mental health have negative consequences?',
                          value: _mentalHealthConsequence,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _mentalHealthConsequence = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would discussing physical health have negative consequences?',
                          value: _physHealthConsequence,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _physHealthConsequence = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would you discuss mental health with coworkers?',
                          value: _coworkers,
                          items: coworkerOptions,
                          onChanged: (value) =>
                              setState(() => _coworkers = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would you discuss mental health with your supervisor?',
                          value: _supervisor,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _supervisor = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would you bring up mental health in an interview?',
                          value: _mentalHealthInterview,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _mentalHealthInterview = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Would you bring up physical health in an interview?',
                          value: _physHealthInterview,
                          items: maybeOptions,
                          onChanged: (value) =>
                              setState(() => _physHealthInterview = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Does your employer take mental health as seriously as physical?',
                          value: _mentalVsPhysical,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _mentalVsPhysical = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 24),

                        CustomDropdown(
                          label:
                              'Have you observed negative consequences from mental health discussions?',
                          value: _obsConsequence,
                          items: yesNoOptions,
                          onChanged: (value) =>
                              setState(() => _obsConsequence = value),
                          validator: (value) =>
                              value == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 40),

                        BlocBuilder<AssessmentCubit, AssessmentState>(
                          builder: (context, state) {
                            if (state is AssessmentLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.cardBackground,
                                ),
                              );
                            }

                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _onSubmit,
                                child: const Text(
                                  'Get Results',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<AssessmentCubit>();

      cubit.updateFormData({
        'family_history': _familyHistory,
        'work_interfere': _workInterfere,
        'leave': _leave,
        'mental_health_consequence': _mentalHealthConsequence,
        'phys_health_consequence': _physHealthConsequence,
        'coworkers': _coworkers,
        'supervisor': _supervisor,
        'mental_health_interview': _mentalHealthInterview,
        'phys_health_interview': _physHealthInterview,
        'mental_vs_physical': _mentalVsPhysical,
        'obs_consequence': _obsConsequence,
      });

      final formData = cubit.formData;
      final input = UserInputModel(
        age: formData['Age'],
        gender: formData['Gender'],
        country: formData['Country'],
        selfEmployed: formData['self_employed'],
        familyHistory: formData['family_history'],
        workInterfere: formData['work_interfere'],
        noEmployees: formData['no_employees'],
        remoteWork: formData['remote_work'],
        techCompany: formData['tech_company'],
        benefits: formData['benefits'],
        careOptions: formData['care_options'],
        wellnessProgram: formData['wellness_program'],
        seekHelp: formData['seek_help'],
        anonymity: formData['anonymity'],
        leave: formData['leave'],
        mentalHealthConsequence: formData['mental_health_consequence'],
        physHealthConsequence: formData['phys_health_consequence'],
        coworkers: formData['coworkers'],
        supervisor: formData['supervisor'],
        mentalHealthInterview: formData['mental_health_interview'],
        physHealthInterview: formData['phys_health_interview'],
        mentalVsPhysical: formData['mental_vs_physical'],
        obsConsequence: formData['obs_consequence'],
      );

      cubit.submitAssessment(input);
    }
  }
}
