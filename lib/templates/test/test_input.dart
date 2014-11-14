

import 'dart:html';

import 'package:wsk/wsk.dart';

/// Application Main
void main() {

  // Addling a listener for Submit button
  final FormElement form = document.querySelector("#usrForm");
  initForm(form);

  // Watching all the input elements getting dirty
  final Map<String, bool> dirtyMap = {};
  final inputsHolder = document.querySelector("#usrForm");
  hookOnDirtyForInputs(inputsHolder, onDirty: (InputElement input) {
    String idOfInput = getNameOfInput(input, idFirst: true);
    dirtyMap[idOfInput] = true;
    window.console.info("dirtyMap: " + dirtyMap.toString());
  });

  // Confirm validation for Email address
  final inputElem_Email = document.querySelector("#frmEmailA") as InputElement;
  final inputElem_EmailConfirm = document.querySelector("#frmEmailC") as InputElement;
  initConfirmValidationForTwoInputs(inputElem_Email, inputElem_EmailConfirm, onInvalid: (InputElement a, InputElement b) => 'The Email addresses must match.');
}

/// Form Setup (Adding listener for a submit button).
void initForm(FormElement form) { //"usrForm"
  form.addEventListener("submit", (Event evt) {
    if (form.checkValidity() == false) {
      evt.preventDefault();
      window.alert("Form is invalid - submission prevented!");
      return false;
    } else {
      // To prevent data from being sent, we've prevented submission
      // here, but normally this code block would not exist.
      evt.preventDefault();
      window.alert("Form is valid - submission prevented to protect privacy.");
      return false;
    }
  });
}

void initFormNoSubmit(FormElement form) {
  form.addEventListener("submit", (Event evt) {
    evt.preventDefault();
    window.alert("Submission of this form is prevented.");
  });
}
