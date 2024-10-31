import tensorflow as tf
import tensorflow_hub as hub

# 모델 로드
hub_module = hub.load('https://tfhub.dev/google/magenta/arbitrary-image-stylization-v1-256/2')

# 입력 및 출력 시그니처 정의
concrete_func = hub_module.signatures['serving_default']

# TensorFlow Lite 변환기 생성
converter = tf.lite.TFLiteConverter.from_concrete_functions([concrete_func])

# 최적화를 위해 양자화 옵션 설정 (선택 사항)
converter.optimizations = [tf.lite.Optimize.DEFAULT]

# TensorFlow Lite 모델로 변환
tflite_model = converter.convert()

# 모델 저장
with open('style_transfer.tflite', 'wb') as f:
    f.write(tflite_model)
