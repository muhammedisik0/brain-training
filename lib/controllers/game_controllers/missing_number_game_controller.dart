import '../../helpers/random_generator.dart';
import 'four_operations_game_controller.dart';

class MissingNumberGameController extends FourOperationsGameController {
  late dynamic firstNumber;
  late dynamic secondNumber;
  late int askedNumber;

  @override
  void generateQuestion() {
    checkIfOperationLoopCompleted();
    operation.setOperator(operationLoop);
    operation.setNumbers();
    setAskedNumber();
  }

  void setAskedNumber() {
    final value = RandomGenerator.generateBool();
    if (value) {
      firstNumber = operation.firstNumber;
      secondNumber = '?';
      askedNumber = operation.secondNumber;
    } else {
      firstNumber = '?';
      secondNumber = operation.secondNumber;
      askedNumber = operation.firstNumber;
    }
  }

  @override
  void generateChoices() {
    listOfChoices = [];
    listOfChoices.addAll([
      askedNumber,
      askedNumber - RandomGenerator.generateInt(10) - 1,
      askedNumber + RandomGenerator.generateInt(10) + 1,
    ]);
    listOfChoices.shuffle();
  }

  @override
  Future<void> checkAnswer(int index) async {
    listOfChoices[index] == askedNumber ? await correct : await wrong;
  }
}
