
import 'dart:io';

void Task1(){
  print('Task 1');
}

Future<String> Task2() async {
  String C = "Task 3";
  Duration duration = Duration(seconds: 5);
  await Future.delayed(duration, () {
    print('Task 2');
  });
  return C;
}

  void Task3(String X){
    print(X);
  }

  void TaskAll() async{
    Task1();
    String X;
    X = await Task2();
    Task3(X);
  }

  void main(){
    TaskAll();
  }