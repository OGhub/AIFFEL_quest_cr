void main() {
  print('Hello, Dart!');
  // 정수형
  int num1 = 10;
  // 실수형
  double num2 = 10.5;
  // 불리언
  bool isTrue = true;
  // 문자열
  String str = 'Hello, Dart!';
  // 리스트
  List<int> list = [1, 2, 3];
  // 맵
  Map<String, int> map = {
    'a': 1,
    'b': 2,
    'c': 3
  };
  // 출력
  print(num1);
  print(num2);
  print(isTrue);
  print(str);
  print(list);
  print(map);
  
  // 변수 타입
  print(num1.runtimeType);
  print(num2.runtimeType);
  print(isTrue.runtimeType);
  print(str.runtimeType);
  print(list.runtimeType);
  print(map.runtimeType);

  // 변환 확인
  print(num1.toString().runtimeType);

  
}

