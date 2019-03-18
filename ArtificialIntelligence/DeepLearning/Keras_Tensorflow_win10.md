# Keras / TensorFlow-GPU環境の作成(Windows)

## 参考

[Keras / TensorFlow-GPU環境の作成（Windows編）](https://dev.infohub.cc/setup_keras_tensorflow_gpu/)

## 備考

### 仮想環境をactivate後、condaコマンドを実行するとcommand not found

仮想環境作成後にいったんanaconda promptを再起動し、再activateでいけた

### tensorflow-gpuインストール後の確認コマンド実行時、CUDA driver version is insufficientエラー

```bash
(keras) C:\Users\kazbo>python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"
2019-03-19 01:42:13.629810: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX AVX2
2019-03-19 01:42:14.933680: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1433] Found device 0 with properties:
name: GeForce GTX 1050 Ti with Max-Q Design major: 6 minor: 1 memoryClockRate(GHz): 1.2905
pciBusID: 0000:01:00.0
totalMemory: 4.00GiB freeMemory: 3.29GiB
2019-03-19 01:42:14.940506: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1512] Adding visible gpu devices: 0
Traceback (most recent call last):

:

tensorflow.python.framework.errors_impl.InternalError: cudaGetDevice() failed. Status: CUDA driver version is insufficient for CUDA runtime version
```
NVIDIAのドライバを以下から419.35にアップデート（ついでにGeForce Experienceをインストール）
https://www.nvidia.co.jp/Download/index.aspx?lang=jp
```
(keras) C:\Users\kazbo>python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"
2019-03-19 01:55:02.546368: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX AVX2
2019-03-19 01:55:03.513027: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1433] Found device 0 with properties:
name: GeForce GTX 1050 Ti with Max-Q Design major: 6 minor: 1 memoryClockRate(GHz): 1.2905
pciBusID: 0000:01:00.0
totalMemory: 4.00GiB freeMemory: 3.30GiB
2019-03-19 01:55:03.524323: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1512] Adding visible gpu devices: 0
2019-03-19 01:55:04.749623: I tensorflow/core/common_runtime/gpu/gpu_device.cc:984] Device interconnect StreamExecutor with strength 1 edge matrix:
2019-03-19 01:55:04.754240: I tensorflow/core/common_runtime/gpu/gpu_device.cc:990]      0
2019-03-19 01:55:04.757334: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1003] 0:   N
2019-03-19 01:55:04.762349: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1115] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 3006 MB memory) -> physical GPU (device: 0, name: GeForce GTX 1050 Ti with Max-Q Design, pci bus id: 0000:01:00.0, compute capability: 6.1)
tf.Tensor(-1074.4451, shape=(), dtype=float32)
```
動いた。