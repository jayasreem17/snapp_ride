
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GenderOption { male, female, preferNotToSay }

abstract class EditDetailsEvent {}

class NameChanged extends EditDetailsEvent {
  final String value;
  NameChanged(this.value);
}

class PhoneChanged extends EditDetailsEvent {
  final String value;
  PhoneChanged(this.value);
}

class EmailChanged extends EditDetailsEvent {
  final String value;
  EmailChanged(this.value);
}

class GenderChanged extends EditDetailsEvent {
  final GenderOption value;
  GenderChanged(this.value);
}

class UpdateDetailsPressed extends EditDetailsEvent {}

class EditDetailsState {
  final String? nameError;
  final String? phoneError;
  final String? emailError;
  final GenderOption gender;
  final bool updated;

  EditDetailsState({
    this.nameError,
    this.phoneError,
    this.emailError,
    this.gender = GenderOption.male,
    this.updated = false,
  });
}

class EditDetailsBloc extends Bloc<EditDetailsEvent, EditDetailsState> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emergencyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  EditDetailsBloc() : super(EditDetailsState()) {
    on<NameChanged>((event, emit) {
      String? error;

      if (event.value.trim().isNotEmpty) {
        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(event.value)) {
          error = 'Only letters are allowed';
        } else if (event.value.trim().length < 3) {
          error = 'Enter at least 3 letters';
        }
      }

      emit(EditDetailsState(
        nameError: error,
        phoneError: state.phoneError,
        emailError: state.emailError,
        gender: state.gender,
      ));
    });

    on<PhoneChanged>((event, emit) {
      String? error;
      String value = event.value;

      if (value.isNotEmpty) {
        if (!RegExp(r'^[6-9]').hasMatch(value)) {
          error = 'Number must start with 6, 7, 8 or 9';
        } else if (value.length < 10) {
          error = 'Enter 10 digit mobile number';
        }
      }

      emit(EditDetailsState(
        nameError: state.nameError,
        phoneError: error,
        emailError: state.emailError,
        gender: state.gender,
      ));
    });

    on<EmailChanged>((event, emit) {
      String? error;
      String value = event.value.trim();

      if (value.isNotEmpty &&
          !RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(value)) {
        error = 'Enter a valid email address';
      }

      emit(EditDetailsState(
        nameError: state.nameError,
        phoneError: state.phoneError,
        emailError: error,
        gender: state.gender,
      ));
    });

    on<GenderChanged>((event, emit) {
      emit(EditDetailsState(
        nameError: state.nameError,
        phoneError: state.phoneError,
        emailError: state.emailError,
        gender: event.value,
      ));
    });

    on<UpdateDetailsPressed>((event, emit) {
      String? nameError;
      String? phoneError;
      String? emailError;

      String name = fullNameController.text.trim();
      String phone = emergencyController.text;
      String email = emailController.text.trim();

      if (name.isEmpty) {
        nameError = 'Full name is required';
      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
        nameError = 'Only letters are allowed';
      } else if (name.length < 3) {
        nameError = 'Enter at least 3 letters';
      }

      if (phone.isEmpty) {
        phoneError = 'Emergency number is required';
      } else if (!RegExp(r'^[6-9]').hasMatch(phone)) {
        phoneError = 'Number must start with 6, 7, 8 or 9';
      } else if (phone.length != 10) {
        phoneError = 'Enter 10 digit mobile number';
      }

      if (email.isNotEmpty &&
          !RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(email)) {
        emailError = 'Enter a valid email address';
      }

      if (nameError != null ||
          phoneError != null ||
          emailError != null) {
        emit(EditDetailsState(
          nameError: nameError,
          phoneError: phoneError,
          emailError: emailError,
          gender: state.gender,
        ));
        return;
      }

      emit(EditDetailsState(
        gender: state.gender,
        updated: true,
      ));
    });
  }

  String get genderText {
    switch (state.gender) {
      case GenderOption.male:
        return 'Male';
      case GenderOption.female:
        return 'Female';
      case GenderOption.preferNotToSay:
        return 'Prefer not to say';
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emergencyController.dispose();
    emailController.dispose();
    return super.close();
  }
}
