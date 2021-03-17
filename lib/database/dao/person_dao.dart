// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:mobile_technologies_task/model/person_model.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPersons();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<Person> findPersonById(int id);

  @insert
  Future<void> insertPerson(Person person);
}