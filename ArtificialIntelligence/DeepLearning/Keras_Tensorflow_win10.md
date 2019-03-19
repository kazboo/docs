# Keras / TensorFlow-GPU環境の作成(Windows)

## 環境構築

[Keras / TensorFlow-GPU環境の作成（Windows編）](https://dev.infohub.cc/setup_keras_tensorflow_gpu/)

* Anaconda Promptで作業をおこなう

### エラー対応

#### 仮想環境をactivate後、condaコマンドを実行するとcommand not found

仮想環境作成後にいったんanaconda promptを再起動し、再activateでいけた

#### tensorflow-gpuインストール後の確認コマンド実行時、CUDA driver version is insufficientエラー

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

## TensorflowチュートリアルをVSCodeで動かす

[Tensorflow Tutorial](https://www.tensorflow.org/tutorials)

### VSCode

[Windows10環境にAnaconda+Visual Studio CodeでPython環境を構築](https://qiita.com/Atupon0302/items/ee3303629ce0b2ae58d7)

* `conda path`も一応指定
  ```
  C:\Users\kazbo\Anaconda3\Scripts
  ```

* `python path`を作成したkeras仮想環境に変更
  ```
  C:\Users\kazbo\Anaconda3\envs\keras
  ```

* 上記設定後pylintのインストール通知がでるのでそのままインストールする(`install`をクリック)
  ```bash
  $ C:/Users/kazbo/Anaconda3/envs/keras/python.exe -m pip install -U pylint
  Collecting pylint
  Downloading https://files.pythonhosted.org/packages/60/c2/b3f73f4ac008bef6
    100% |████████████████████████████████| 768kB 3.3MB/s
  Collecting astroid<3,>=2.2.0 (from pylint)
  Downloading https://files.pythonhosted.org/packages/d5/ad/7221a62a2dbce5c3
    100% |████████████████████████████████| 194kB 4.9MB/s
  Collecting mccabe<0.7,>=0.6 (from pylint)
  Downloading https://files.pythonhosted.org/packages/87/89/479dc97e18549e21
  Collecting isort<5,>=4.2.5 (from pylint)
  Downloading https://files.pythonhosted.org/packages/b6/89/3137d13dd30a0d06
    100% |████████████████████████████████| 51kB 3.9MB/s
  Collecting colorama; sys_platform == "win32" (from pylint)
  Downloading https://files.pythonhosted.org/packages/4f/a6/728666f39bfff171
  Collecting lazy-object-proxy (from astroid<3,>=2.2.0->pylint)
  Downloading https://files.pythonhosted.org/packages/7c/71/e7a10cab32c9fc37
  Collecting wrapt (from astroid<3,>=2.2.0->pylint)
  Downloading https://files.pythonhosted.org/packages/67/b2/0f71ca90b0ade7fa
  Requirement already satisfied, skipping upgrade: six in c:\users\kazbo\anaco
  Collecting typed-ast>=1.3.0; implementation_name == "cpython" (from astroid<
  Downloading https://files.pythonhosted.org/packages/5e/43/de06013ff66c70c4
    100% |████████████████████████████████| 163kB 2.6MB/s
  Building wheels for collected packages: wrapt
  Building wheel for wrapt (setup.py) ... done
  Stored in directory: C:\Users\kazbo\AppData\Local\pip\Cache\wheels\89\67\4
  Successfully built wrapt
  Installing collected packages: lazy-object-proxy, wrapt, typed-ast, astroid,, typed-ast, astroid, mccabe, isort, colorama, pylint  
  Anaconda3\envs\keras\
  The script isort.exe is installed in 'C:\Users\kazbo\fer to suppress this Anaconda3\envs\keras\Scripts' which is not on PATH.    
  d symilar.exe are ins
  Consider adding this directory to PATH or, if you prefer to suppress this fer to suppress this warning, use --no-warn-script-locart-4.3.15 lazy-objecttion.
  The scripts epylint.exe, pylint.exe, pyreverse.exe anxd symilar.exe are installed in 'C:\Users\kazbo\Anaconda3\envs\keras\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.tion.                                                  rt-4.3.15 lazy-objectSuccessfully installed astroid-2.2.5 colorama-0.4.1 isort-4.3.15 lazy-object-proxy-1.3.1 mccabe-0.6.1 pylint-2.3.1 typed-ast-1.3.1 wrapt-1.11.1
  ```

## チュートリアル実行

* Tutorialのコードをtest.pyとして保存
  ```python
  import tensorflow as tf
  mnist = tf.keras.datasets.mnist

  (x_train, y_train), (x_test, y_test) = mnist.load_data()
  x_train, x_test = x_train / 255.0, x_test / 255.0

  model = tf.keras.models.Sequential([
      tf.keras.layers.Flatten(input_shape=(28, 28)),
      tf.keras.layers.Dense(512, activation=tf.nn.relu),
      tf.keras.layers.Dropout(0.2),
      tf.keras.layers.Dense(10, activation=tf.nn.softmax)
  ])
  model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

  model.fit(x_train, y_train, epochs=5)
  model.evaluate(x_test, y_test)
  ```

* vscode上でデバッグ実行
  ```bash
  $ cd "c:\Users\kazbo\workspace\python-sandbox" ; env PYTHONIOENCODING=UTF-8 PYTHONUNBUFFERED=1 "C:\Users\kazbo\Anaconda3\envs\keras\python.exe" "c:\Users\kazbo\.vscode\extensions\ms-python.python-2019.2.5558\pythonFiles\ptvsd_launcher.py" --default --client --host localhost --port 53990 "c:\Users\kazbo\workspace\python-sandbox\test.py"
  WARNING:tensorflow:From C:\Users\kazbo\Anaconda3\envs\keras\lib\site-packages\tensorflow\python\ops\resource_variable_ops.py:435: colocate_with (from tensorflow.python.framework.ops) is deprecated and will be removed in a future version.
  Instructions for updating:
  Colocations handled automatically by placer.
  WARNING:tensorflow:From C:\Users\kazbo\Anaconda3\envs\keras\lib\site-packages\tensorflow\python\keras\layers\core.py:143: calling dropout (from tensorflow.python.ops.nn_ops) with keep_prob is deprecated and will be removed in a future version.
  Instructions for updating:
  Please use `rate` instead of `keep_prob`. Rate should be set to `rate = 1 - keep_prob`.
  2019-03-19 12:00:10.524798: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX AVX2
  2019-03-19 12:00:11.465160: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1433] Found device 0 with properties:
  name: GeForce GTX 1050 Ti with Max-Q Design major: 6 minor: 1 memoryClockRate(GHz): 1.2905
  pciBusID: 0000:01:00.0
  totalMemory: 4.00GiB freeMemory: 3.30GiB
  2019-03-19 12:00:11.472031: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1512] Adding visible gpu devices: 0
  2019-03-19 12:00:12.103266: I tensorflow/core/common_runtime/gpu/gpu_device.cc:984] Device interconnect StreamExecutor with strength 1 edge matrix:
  2019-03-19 12:00:12.107939: I tensorflow/core/common_runtime/gpu/gpu_device.cc:990]      0
  2019-03-19 12:00:12.110299: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1003] 0:   N
  2019-03-19 12:00:12.112784: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1115] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 3006 MB memory) -> physical GPU (device: 0, name: GeForce GTX 1050 Ti with Max-Q Design, pci bus id: 0000:01:00.0, compute capability: 6.1)
  Epoch 1/5
  2019-03-19 12:00:12.632474: I tensorflow/stream_executor/dso_loader.cc:152]
  successfully opened CUDA library cublas64_100.dll locally
   32/60000 [..............................] - ETA: 12:52 - loss: 2.4122 - a
   :
   60000/60000 [==============================] - 8s 139us/sample - loss: 0.2177 - acc: 0.9360

  :

  Epoch 5/5
   32/60000 [..............................] - ETA: 11s - loss: 0.0891 - acc
   :
   10000/10000 [==============================] - 1s 80us/sample - loss: 0.0647 - acc: 0.9824
  ```

## 用語

[TensorFlowとKerasを比較](https://www.ossnews.jp/compare/TensorFlow/Keras)

### Tensorflow

* GoogleのDeep Learningライブラリ
* 特徴
  * データフローグラフによる柔軟性
  * ローレベルオペレータも手書きできる汎用性
  * 高いパフォーマンス、スケーラビリティ
  * 研究レベルから実プロダクトまで扱える効率性

### Keras

* OSSのニューラルネットワークライブラリ
* バックエンドにTensorFlowを利用するディープラーニングライブラリラッパー
* 特徴
  * より高いレベルでより直感的な抽象化を提供しているため、NN設計を容易に行える
  * 以下のバックエンドをサポートする
    * TensorFlow(Google)
    * MS Cognitive Toolkit(Microsoft)
    * Theano

