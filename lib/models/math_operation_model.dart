import 'package:function_tree/function_tree.dart';

import '../helpers/random_generator.dart';

class MathOperation {
  MathOperation();

  late int firstNumber;
  late int secondNumber;
  late String operator;
  List<String> listOfOperators = ['+', '-', '*', '/'];

  void shuffleListOfOperators() => listOfOperators.shuffle();

  void setOperator(int value) => operator = listOfOperators[value - 1];

  void setNumbers() {
    switch (operator) {
      case '+':
        setForAddition();
        break;
      case '-':
        setForSubtraction();
        break;
      case '*':
        setForMultiplication();
        break;
      case '/':
        setForDivision();
        break;
    }
  }

  void setForAddition() {
    firstNumber = RandomGenerator.generateInt(80) + 10;
    secondNumber = RandomGenerator.generateInt(10) + 10;
  }

  void setForSubtraction() {
    final difference = RandomGenerator.generateInt(10) + 10;
    secondNumber = RandomGenerator.generateInt(80) + 10;
    firstNumber = secondNumber + difference;
  }

  void setForMultiplication() {
    firstNumber = RandomGenerator.generateInt(97) + 3;
    if (firstNumber % 10 == 0 || firstNumber == 5) {
      secondNumber = RandomGenerator.generateInt(10) + 5;
    } else if (firstNumber < 20) {
      secondNumber = RandomGenerator.generateInt(7) + 3;
    } else {
      secondNumber = RandomGenerator.generateInt(4) + 2;
    }
  }

  void setForDivision() {
    int value = RandomGenerator.generateInt(80);
    if (value % 10 == 0 || value == 5) {
      secondNumber = RandomGenerator.generateInt(7) + 3;
    } else {
      value = RandomGenerator.generateInt(3) + 3;
      secondNumber = RandomGenerator.generateInt(80) + 10;
    }
    firstNumber = secondNumber * value;
  }

  String get wholeOperation => '$firstNumber $operator $secondNumber';

  num get result => wholeOperation.interpret().round();
}
