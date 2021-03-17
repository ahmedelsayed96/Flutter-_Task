import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_technologies_task/model/person_model.dart';

abstract class RegistrationEvent extends Equatable {
  RegistrationEvent();

  List get props => [];
}

class RegistrationAppStart extends RegistrationEvent {}

class RegistrationInsert extends RegistrationEvent {
  final Person person;

  RegistrationInsert({@required this.person});

  @override
  List get props => [person];
}
