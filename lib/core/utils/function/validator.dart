String? validateEmail(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Email cannot be empty';
  }

  // Improved email regex pattern
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (!emailRegex.hasMatch(val.trim())) {
    return 'Enter a valid email address';
  }

  return null;
}


String? validatePassword(String? val) {
  if (val == null || val.isEmpty) {
    return 'Password cannot be empty';
  }
  if (val.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? validateFullName(String? val) {
  if (val == null || val.isEmpty) {
    return 'username cannot be empty';
  }
  return null;
}

String? validateSearch(String? val) {
  if (val == null || val.isEmpty) {
    return 'Search cannot be empty';
  }
  return null;
}
String? validateTeamName(String? val) {
  if (val == null || val.isEmpty) {
    return 'Team name cannot be empty';
  }
  return null;
}
String? validateDescription(String? val) {
  if (val == null || val.isEmpty) {
    return 'Description cannot be empty';
  }
  return null;
}

String? validateNbre(String? val) {
  if (val == null || val.isEmpty) {
    return 'Nbre Members cannot be empty';
  }
  return null;
}

/* add validate phone* */

String? validatePhone(String? val) {
  if (val == null || val.isEmpty) {
    return 'Phone number cannot be empty';
  }
  final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
  if (!phoneRegex.hasMatch(val)) {
    return 'Enter a valid  phone number at least 8 digits';
  }
  return null;
}
