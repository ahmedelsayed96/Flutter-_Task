# Flutter Task documentaion

Customer Registration screen
============================
[IMEI]		 ____________ [auto-populated by default. If not available, let user enter it.]
[First name] ____________
[Last name]  ____________
[DoB]        ____________ [Calendar, Date format = dd/MM/yyyy]
[Passport #] ____________ [Visible and mandatory ONLY when person is 18+]
[Email]      ____________
[Picture]    ____________ [Capture from Camera]

					[Save]

Validations
===========
	All fields are mandatory excluding 'Email'
	All fields should have some sort of relevant constraint(s)

Save button action
==================
	Prepares the data and saves it in local storage (e.g. Sqlite)
	Picture is to be saved on SD card but it's full-path will be stored in database table.
	Additional fields to save for each registration: Device Name (e.g. Android or iOS), Latitute, Longitude
	
Output
==================
1. source code
2. Android APK
3. iOS app
4. Documentation
5. Screenshots of UI and DB (on Android and iOS)

# Screen shoots 
<img src="https://github.com/ahmedelsayed96/Flutter-_Task/raw/master/screens/Screen%20Shot%202021-03-17%20at%203.24.25%20PM.png" height="400" alt="GIF"/>
<img src="https://github.com/ahmedelsayed96/Flutter-_Task/raw/master/screens/Screen%20Shot%202021-03-17%20at%203.24.34%20PM.png" height="400" alt="GIF"/>
<br>
<img src="https://github.com/ahmedelsayed96/Flutter-_Task/raw/master/screens/Screen%20Shot%202021-03-17%20at%203.27.53%20PM.png"  alt="GIF"/>



# Code Documentation

## registration _bloc.dart

responsible for  initializing the database and insert persons in the persons table 
      
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
      
      /// Creating the data base when app open or open it if exist  
      Stream<RegistrationState> dbInit(RegistrationEvent event) async* {  
        try {  
          yield RegistrationLoading();  
     final database =  
              await $FloorAppDatabase.databaseBuilder('task_database.db').build();  
      dao = database.personDao;  
     yield RegistrationInitial();  
      } catch (e) {  
          print(e.toString());  
      }  
      }  
      
      /// insert person into persons Table  
      Stream<RegistrationState> registerPerson(RegistrationInsert event) async* {  
        try {  
          yield RegistrationLoading();  
      LocationData location = await Location().getLocation();  
      event.person.latitute = location.longitude;  
      event.person.longitude = location.longitude;  
      event.person.deviceName = Platform.operatingSystem;  
     await dao.insertPerson(event.person);  
     yield RegistrationSuccess();  
      } catch (e) {  
          yield RegistrationFailure(error: e.toString());  
      }  
      }  
    }

## registration_sreen.dart

responsible for  display ui and call the registration bloc to insert person       
    class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {  
      PersonDao dao;  
      
         class RegistrationScreen extends StatefulWidget {  
      @override  
      _RegistrationScreenState createState() => _RegistrationScreenState();  
    }  
      
    class _RegistrationScreenState extends State<RegistrationScreen> {  
      @override  
      Widget build(BuildContext context) {  
        return Scaffold(  
          appBar: AppBar(  
            title: Text('SignUp'),  
      ),  
      body: buildSignUpBody(),  
      );  
      }  
      
      Widget buildSignUpBody() {  
        return SingleChildScrollView(  
          child: Form(  
            key: _formKey,  
      child: Padding(  
              padding: const EdgeInsets.all(16.0),  
      child: Column(  
                children: [  
                  buildStackImage(),  
      HeightBox(16),  
      buildIMEI(),  
      HeightBox(16),  
      buildFirstName(),  
      HeightBox(16),  
      buildLastName(),  
      HeightBox(16),  
      buildDOBEditText(),  
      HeightBox(16),  
     if (hasPassport) buildPassport(),  
     if (hasPassport) HeightBox(16),  
      buildEmail(),  
      HeightBox(30),  
      buildSaveButton()  
                ],  
      ),  
      ),  
      ),  
      );  
      }  
      
