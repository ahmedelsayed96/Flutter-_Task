import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  RegistrationState();

  List get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({@required this.error});

  List get props => [error];
}
