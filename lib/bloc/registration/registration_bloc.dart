import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:mobile_technologies_task/database/dao/person_dao.dart';
import 'package:mobile_technologies_task/database/db/database.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  PersonDao dao;

  RegistrationBloc() : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationAppStart) {
      yield* dbInit(event);
    } else if (event is RegistrationInsert) {
      yield* registerPerson(event);
    }
  }

  Stream<RegistrationState> dbInit(RegistrationEvent event) async* {
    try {
      yield RegistrationLoading();
      final database =
      await $FloorAppDatabase.databaseBuilder('task_database.db').build();
      dao = database.personDao;
      yield RegistrationInitial();
    }catch (e){
      print(e.toString());
    }
  }

  Stream<RegistrationState> registerPerson(RegistrationInsert event) async* {
    try {
      yield RegistrationLoading();
      LocationData  location =await Location().getLocation();
      event.person.latitute=location.longitude;
      event.person.longitude=location.longitude;
      event.person.deviceName=Platform.operatingSystem;
      await dao.insertPerson(event.person);
      yield RegistrationSuccess();
    } catch (e) {
      yield RegistrationFailure(error: e.toString());
    }
  }
}
