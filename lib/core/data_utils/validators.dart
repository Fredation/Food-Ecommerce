class MyFormValidator {
  static String? emailErr;
  static String? passwordErr;
  static String? phoneErr;
  static String? ageErr;
  static String? amountErr;
  static String? contentErr;
  static String? nameErr;

  static String? validatePassword(String? val) {
    // log(val);

    final value = val!.trim();

    if (value.isEmpty) {
      passwordErr = 'Input field cannot be empty';
      return 'Input field cannot be empty';
    }

    // if (RegExp("^(?=.*[0-9])(?=.*[A-Za-z])(?=.{8,})").hasMatch(value)) {
    if (value.length < 6) {
      passwordErr = 'Password must be at least 6 characters';
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? validateEmail(String? val) {
    final value = val!.trim();
    if (value.isEmpty) {
      emailErr = 'Input field cannot be empty';
      return 'Input field cannot be empty';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!(regex.hasMatch(value))) {
      emailErr = 'Please enter a valid email address';
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateAge(String? age) {
    if (age == null) {
      ageErr = 'Input field cannot be empty';
      return 'Input field cannot be empty';
    }
    if (int.tryParse(age) == null) {
      ageErr = 'Invalid age';
      return 'Invalid age';
    }
    if (int.tryParse(age) != null) {
      if (int.tryParse(age)! < 13) {
        ageErr = 'Age must be from 13 and above';
        return 'Age must be from 13 and above';
      }
    }

    return null;
  }

  // static
  static String? validateAmount(String? num) {
    num = num!.replaceAll(',', '');
    if (num == '') return null;
    if (double.tryParse(num) == null) {
      amountErr = 'Input a valid amount';
      return 'Input a valid amount';
    }
    return null;
  }

  static String? validateContent(String? val) {
    final value = val ?? '';
    if (value.isEmpty) {
      contentErr = 'Input field cannot be empty';
      return 'Input field cannot be empty';
    }

    return null;
  }

  static String? validateName(String? val) {
    final value = val!.trim();
    if (value.isEmpty) {
      nameErr = 'Input field cannot be empty';
      return 'Input field cannot be empty';
    }
    // if (!RegExp('^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}{-}\$').hasMatch(value)) {
    // if (!RegExp('^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}{-}\$').hasMatch(value)) {
    //   return 'Uhhh oh! provide a valid name';
    // }
    if (value.length < 2) {
      nameErr = 'Name must be at least 2 characters';
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validatePhonenumber(String? str) {
    RegExp regExp = RegExp(
      r"^\d{11}$",
    );

    if (!regExp.hasMatch(str!)) {
      phoneErr = 'Invalid phone number';
      return 'Invalid phone number';
    } else {
      return null;
    }
  }
}
