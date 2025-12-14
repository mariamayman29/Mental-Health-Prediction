import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../cubits/assessment_cubit.dart';
import '../../widgets/custom_dropdown.dart';
import 'mental_health_screen.dart';

class WorkInfoScreen extends StatefulWidget {
  const WorkInfoScreen({Key? key}) : super(key: key);

  @override
  State<WorkInfoScreen> createState() => _WorkInfoScreenState();
}

class _WorkInfoScreenState extends State<WorkInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  int _noEmployees = 50;
  String? _remoteWork;
  String? _techCompany;
  String? _benefits;
  String? _careOptions;
  String? _wellnessProgram;
  String? _seekHelp;
  String? _anonymity;

  final List<String> yesNoOptions = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),

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
                          'About your workplace',
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
                          'Tell us about your work environment and benefits',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Text(
                        'Company Size: $_noEmployees employees',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _noEmployees.toDouble(),
                        min: 1,
                        max: 1000,
                        divisions: 100,
                        label: _noEmployees.toString(),
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _noEmployees = value.toInt();
                          });
                        },
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Do you work remotely?',
                        value: _remoteWork,
                        items: yesNoOptions,
                        onChanged: (value) =>
                            setState(() => _remoteWork = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Is this a tech company?',
                        value: _techCompany,
                        items: yesNoOptions,
                        onChanged: (value) =>
                            setState(() => _techCompany = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label:
                            'Does your employer provide mental health benefits?',
                        value: _benefits,
                        items: yesNoOptions,
                        onChanged: (value) => setState(() => _benefits = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Do you know the care options available?',
                        value: _careOptions,
                        items: yesNoOptions,
                        onChanged: (value) =>
                            setState(() => _careOptions = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Does your employer have a wellness program?',
                        value: _wellnessProgram,
                        items: yesNoOptions,
                        onChanged: (value) =>
                            setState(() => _wellnessProgram = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label:
                            'Does your employer provide resources to seek help?',
                        value: _seekHelp,
                        items: yesNoOptions,
                        onChanged: (value) => setState(() => _seekHelp = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Is anonymity protected when seeking help?',
                        value: _anonymity,
                        items: yesNoOptions,
                        onChanged: (value) =>
                            setState(() => _anonymity = value),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onNext,
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      context.read<AssessmentCubit>().updateFormData({
        'no_employees': _noEmployees,
        'remote_work': _remoteWork,
        'tech_company': _techCompany,
        'benefits': _benefits,
        'care_options': _careOptions,
        'wellness_program': _wellnessProgram,
        'seek_help': _seekHelp,
        'anonymity': _anonymity,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MentalHealthScreen()),
      );
    }
  }
}
