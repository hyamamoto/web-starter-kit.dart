part of wsk;

typedef void InputDirtyListener(InputElement input);

void hookOnDirtyForInputs(Element elementInputsHolder, {InputDirtyListener onDirty}) {
  final inputs = elementInputsHolder.querySelectorAll("input");
  final inputs_len = inputs.length;
  var addDirtyClass = (Event evt) {
    final inputElement = evt.target as InputElement;
    onDirty(inputElement);
    inputElement.classes.toggle("dirty", true);
  };
  for (var i = 0; i < inputs_len; i++) {
    var input = inputs[i] as Element;
    input.addEventListener("blur", addDirtyClass);
    input.addEventListener("invalid", addDirtyClass);
    input.addEventListener("valid", addDirtyClass);
  }
}

typedef void TwoInputsValidListener(InputElement first, InputElement second);
typedef String TwoInputsInvalidListener(InputElement first, InputElement second);

void initConfirmValidationForTwoInputs(InputElement inputElem_Master, InputElement inputElem_Confirm, {TwoInputsValidListener onValid, TwoInputsInvalidListener onInvalid}) {
  if (onValid == null) onValid = (InputElement f, InputElement s) => {};
  if (onInvalid == null) onInvalid = (InputElement f, InputElement s) => 'The two input fields must match.';

  void verifyTwoInputs(Event evt) {
    final inputElemToCompare = evt.target as InputElement; // eveny source
    final primaryValue = inputElem_Master.value;
    final secondaryValue = inputElemToCompare.value;

    if (secondaryValue != primaryValue) {
      // the provided value doesn't match the primary email address
      final messageInvalid = onInvalid(inputElem_Master, inputElemToCompare);
      inputElemToCompare.setCustomValidity(messageInvalid);

      final nameA = getNameOfInput(inputElem_Master);
      final nameC = getNameOfInput(inputElemToCompare);
      window.console.log(nameA + " and " + nameC + " do not match: " + primaryValue + ", " + secondaryValue);
    } else {
      // input is valid -- reset the error message
      inputElemToCompare.setCustomValidity('');
      onValid(inputElem_Master, inputElemToCompare);
    }
  }
  inputElem_Confirm.addEventListener("blur", verifyTwoInputs);
}

String getNameOfInput(InputElement inputElement, {bool idFirst}) {
  String name;
  final name_isEmpty = () => name == null || name.isEmpty;

  if (idFirst) name = inputElement.id;
  if (name_isEmpty()) {
    for (Node labelNode in inputElement.labels) {
      name = labelNode.text;
      break;
    }
  }
  if (name_isEmpty()) name = inputElement.title;
  if (name_isEmpty()) name = inputElement.name;
  if (name_isEmpty()) name = inputElement.id;
  return name;
}
