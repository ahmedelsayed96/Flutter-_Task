import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mobile_technologies_task/bloc/registration/registration_bloc.dart';
import 'package:mobile_technologies_task/bloc/registration/registration_event.dart';
import 'package:mobile_technologies_task/bloc/registration/registration_state.dart';
import 'package:mobile_technologies_task/model/person_model.dart';
import 'package:mobile_technologies_task/utlities/age_calculator.dart';
import 'package:mobile_technologies_task/utlities/image_picker.dart';
import 'package:mobile_technologies_task/utlities/imei.dart';
import 'package:mobile_technologies_task/utlities/validator.dart';
import 'package:mobile_technologies_task/widgets/app_button.dart';
import 'package:mobile_technologies_task/widgets/app_edit_text.dart';
import 'package:mobile_technologies_task/widgets/size.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController iMEITextEditingController = TextEditingController();

  TextEditingController firstNameTextEditingController =
      TextEditingController();

  TextEditingController lastNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController dOBTextEditingController = TextEditingController();

  TextEditingController passportTextEditingController = TextEditingController();

  DateTime selectedDOB;

  var _formKey = GlobalKey<FormState>();
  File imageFile;

  bool get hasPassport {
    if (selectedDOB != null && AgeCalculator.calculateAge(selectedDOB) >= 18)
      return true;
    return false;
  }

  RegistrationBloc registrationBloc;

  @override
  void initState() {
    registrationBloc = BlocProvider.of(context);
    registrationBloc.add(RegistrationAppStart());
    AppIMEI.initPlatformState().then((value) {
      iMEITextEditingController.text = value;
    });
    super.initState();
  }

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

  Widget buildSaveButton() {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: registrationListener,
        builder: (context, state) {
          return state is RegistrationLoading
              ? buildLoading()
              : AppButton(
                  text: 'Save',
                  onTap: () async {
                    PermissionStatus _permissionGranted =
                        await Location().requestPermission();

                    if (_formKey.currentState.validate() &&
                        _permissionGranted == PermissionStatus.granted) {
                      registrationBloc.add(RegistrationInsert(
                          person: Person(
                              iMEITextEditingController.text,
                              firstNameTextEditingController.text,
                              lastNameTextEditingController.text,
                              dOBTextEditingController.text,
                              emailTextEditingController.text,
                              passportTextEditingController.text,
                              imageFile?.path ?? null)));
                    }
                  },
                );
        });
  }

  Center buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  AppEditText buildIMEI() {
    return AppEditText(
      labelText: 'IMEI',
      controller: iMEITextEditingController,
      validator: AppValidator.validatorRequired,
    );
  }

  AppEditText buildFirstName() {
    return AppEditText(
      labelText: 'First Name',
      controller: firstNameTextEditingController,
      validator: AppValidator.validatorRequired,
    );
  }

  AppEditText buildLastName() {
    return AppEditText(
      labelText: 'Last Name',
      controller: lastNameTextEditingController,
      validator: AppValidator.validatorRequired,
    );
  }

  Widget buildPassport() {
    return AppEditText(
      labelText: 'Passport',
      textInputType: TextInputType.number,
      controller: passportTextEditingController,
      validator: AppValidator.validatorRequired,
    );
  }

  Widget buildEmail() {
    return AppEditText(
      labelText: 'Email',
      validator: AppValidator.validatorEmail,
      controller: emailTextEditingController,
    );
  }

  Widget buildDOBEditText() {
    return InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2000, 1),
            firstDate: DateTime(1900, 1),
            lastDate: DateTime.now(),
          ).then((pickedDate) {
            setState(() {
              selectedDOB = pickedDate;
              dOBTextEditingController.text =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          });
        },
        child: IgnorePointer(
          child: AppEditText(
            labelText: 'Date of Birth',
            readOnly: true,
            controller: dOBTextEditingController,
            validator: AppValidator.validatorRequired,
          ),
        ));
  }

  Widget buildStackImage() {
    return InkWell(
        onTap: loadAssets,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: imageFile != null
                    ? FileImage(
                        imageFile,
                      )
                    : NetworkImage(
                        'https://hungrygen.com/wp-content/uploads/2019/11/placeholder-male-square.png',
                      )),
          ),
        ));
  }

  Future<void> loadAssets() async {
    AppImagePicker.showPicker(context, (File image) {
      if (!mounted) return;
      setState(() {
        imageFile = image;
      });
    });
  }

  void registrationListener(BuildContext context, RegistrationState state) {
    if (state is RegistrationSuccess) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Success',
        desc: 'Registration success',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    } else if (state is RegistrationFailure) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: state.error,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    }
  }
}
