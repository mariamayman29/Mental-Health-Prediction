import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../cubits/assessment_cubit.dart';
import '../../widgets/custom_dropdown.dart';
import 'work_info_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  int _age = 25;
  String? _gender;
  String? _country;
  String? _selfEmployed;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Germany',
    'India',
    'Australia',
    'France',
    'Netherlands',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: AppColors.cardBackground),
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
                          'Tell us about yourself',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardBackground,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'This information helps us provide better insights',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.cardBackground,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Age: $_age',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      Slider(
                        value: _age.toDouble(),
                        min: 18,
                        max: 80,
                        divisions: 62,
                        label: _age.toString(),

                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _age = value.toInt();
                          });
                        },
                      ),

                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Gender',
                        value: _gender,
                        items: genderOptions,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Country',
                        value: _country,
                        items: countries,
                        onChanged: (value) {
                          setState(() {
                            _country = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your country';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      CustomDropdown(
                        label: 'Are you self-employed?',
                        value: _selfEmployed,
                        items: yesNoOptions,
                        onChanged: (value) {
                          setState(() {
                            _selfEmployed = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
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
        'Age': _age,
        'Gender': _gender,
        'Country': _country,
        'self_employed': _selfEmployed,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WorkInfoScreen()),
      );
    }
  }
}
