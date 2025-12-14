import 'package:equatable/equatable.dart';

class UserInputModel extends Equatable {
  final int age;
  final String gender;
  final String country;
  final String selfEmployed;
  final String familyHistory;
  final String workInterfere;
  final int noEmployees;
  final String remoteWork;
  final String techCompany;
  final String benefits;
  final String careOptions;
  final String wellnessProgram;
  final String seekHelp;
  final String anonymity;
  final String leave;
  final String mentalHealthConsequence;
  final String physHealthConsequence;
  final String coworkers;
  final String supervisor;
  final String mentalHealthInterview;
  final String physHealthInterview;
  final String mentalVsPhysical;
  final String obsConsequence;

  const UserInputModel({
    required this.age,
    required this.gender,
    required this.country,
    required this.selfEmployed,
    required this.familyHistory,
    required this.workInterfere,
    required this.noEmployees,
    required this.remoteWork,
    required this.techCompany,
    required this.benefits,
    required this.careOptions,
    required this.wellnessProgram,
    required this.seekHelp,
    required this.anonymity,
    required this.leave,
    required this.mentalHealthConsequence,
    required this.physHealthConsequence,
    required this.coworkers,
    required this.supervisor,
    required this.mentalHealthInterview,
    required this.physHealthInterview,
    required this.mentalVsPhysical,
    required this.obsConsequence,
  });

  Map<String, dynamic> toJson() => {
    'Age': age,
    'Gender': gender,
    'Country': country,
    'self_employed': selfEmployed,
    'family_history': familyHistory,
    'work_interfere': workInterfere,
    'no_employees': noEmployees,
    'remote_work': remoteWork,
    'tech_company': techCompany,
    'benefits': benefits,
    'care_options': careOptions,
    'wellness_program': wellnessProgram,
    'seek_help': seekHelp,
    'anonymity': anonymity,
    'leave': leave,
    'mental_health_consequence': mentalHealthConsequence,
    'phys_health_consequence': physHealthConsequence,
    'coworkers': coworkers,
    'supervisor': supervisor,
    'mental_health_interview': mentalHealthInterview,
    'phys_health_interview': physHealthInterview,
    'mental_vs_physical': mentalVsPhysical,
    'obs_consequence': obsConsequence,
  };

  @override
  List<Object?> get props => [
    age,
    gender,
    country,
    selfEmployed,
    familyHistory,
    workInterfere,
    noEmployees,
    remoteWork,
    techCompany,
    benefits,
    careOptions,
    wellnessProgram,
    seekHelp,
    anonymity,
    leave,
    mentalHealthConsequence,
    physHealthConsequence,
    coworkers,
    supervisor,
    mentalHealthInterview,
    physHealthInterview,
    mentalVsPhysical,
    obsConsequence,
  ];
}
