import 'package:eunoia/data/repositories/mental_health_repositories.dart';
import 'package:eunoia/data/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubits/assessment_cubit.dart';
import 'presentation/screens/splash_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const Eunoia());
}

class Eunoia extends StatelessWidget {
  const Eunoia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MentalHealthRepository(apiService: ApiService()),
      child: BlocProvider(
        create: (context) =>
            AssessmentCubit(repository: context.read<MentalHealthRepository>()),
        child: MaterialApp(
          title: 'Mental Health Assistant',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(color: Colors.black),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
