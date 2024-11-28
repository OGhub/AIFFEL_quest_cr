# AIFFEL_quest_cr

많은 모델으로 실험해보지는 못했다.  
EfficientNetB0으로 진행했다.  
![image](https://github.com/user-attachments/assets/53d766c6-0457-4a25-8a11-c5e2e3897d71)

훈련 정확도 99% 에 훈련 손실은 0.02 으로 상당히 잘 나왔다.  

구글 코랩에서 진행했는데 처음에 .keras로 저장해서 모델이 테스트 성능이 50% 나오는 문제가 있었는데,   
한참 해결을 못하다가, .h5으로 저장해서 로드 하니 그러한 문제가 없어졌다.  

![image](https://github.com/user-attachments/assets/c6743d32-8180-4c07-b3fe-10947ba8d32a)

플러터에서 모델 연동이 어려웠다. 외관은 그럴싸한데, 예측이 안된다
tflite모듈이 뭔가 인식이 안되는것 같다.
![image](https://github.com/user-attachments/assets/4c899150-d594-4c01-bf61-052128e5b621)


![image](https://github.com/user-attachments/assets/35b55c73-4c67-463f-af52-f863e9c7b45f)
![image](https://github.com/user-attachments/assets/84f1a582-0f04-4ef4-91da-b9ea6683baf5)

권오근 회고.
모델 훈련까지는 되었지만 플러터를 연동하는 과정에서 많은 어려움이 있었다.  
