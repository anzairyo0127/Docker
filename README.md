# 追記予定
スタートアップ

# Docker物置場

Dockerで使用するファイルをアップロードしています。

- Dockerfile
- docker-compose
- .env.example(Docker Composeで使用)

## Dockerfileの使い方

### Dockerfileを使ったbuild方法

カレントディレクトリをDockerfileのあるディレクトにした状態で

```docker build -t ****(好きな名前) .```

と打ってください。コマンド末のピリオドを忘れずに。


### Dockerfileの編集

Dockerfileを編集する際はメモ帳ですとか、viなどで開いてください。

#### PythonVersionの指定
```
# PythonVersion指定
ARG version="3.6.5"
```
pyenvを使用したバージョンの指定になります。

よって、導入Verの設定はpyenvの方法に則ります。

Python Ver3.6.5を導入したい場合は`ARG version="3.6.5"`と記載。

Python Ver2.7.15を導入したい場合は`ARG version="2.7.15"`と記載。


#### pyenvのPATHの値

```
# Command"pyenv"のPATHの値
ARG pyenvpath="/.pyenv"
```

コンテナ内のpyenvコマンドを実行するための環境変数PATHの設定を行うための個所になります。

こちらもこのままでよいと思いますが、いわゆる手動設定のため、

幾ばくかのcommandの動作が怪しいときは変えてみるといいかもしれません。

例`ARG pyenvpath="/ec/.pyenv"`


## docker-composeの使い方

docker-composeはyml形式ですので、メモ帳でもVSCodeでもviでも開けます。

具体的な値は`.env`の変数を変更して使用します。

もちろん、このファイルに直接書き込んでも動作しますが、基本的には`.env`を編集してください。

`.env.example`を一緒にコミットしますので、`コピー＆ペースト`ですとか`cp .env.example .env`で

コピーして使用してください。なお、`.env`は`.gitignore`にてアップロードされないようになってます。


## .env.exampleの使い方

docker-composeの中身の変数がこちらに記載されています。

#### WIMAGE

`WIMAGE=name_image`はdockerのコンテナ化の際に使用するimage名を記載してください。

例`WIMAGE=ubuntu`等......


#### WTAG

`WTAG=use_tag`は上記imageのタグ部分になります。

例`WTAG=latest`


#### WPORT1、WPORT2

`WPORT1=8888`はホストOSの開放するポート番号です。

`WPORT2=6666`はコンテナの開放するポート番号です。

例ではホストOSのIPのポート番号8888にアクセスされた際、コンテナのIPのポート番号6666にアクセスされるようになります。


#### WHOSTMOUNT、WENVIMOUNT

ホストOSのフォルダ、ディレクトリがコンテナ内のディレクトリにマウントされます。

つまり、ホストOSのフォルダの中身が、コンテナ内に共有されます。

`WHOSTMOUNT=C:\Users\example\www`はホストOSの共有して作業するフォルダのパス

`WENVIMOUNT=/project/www`はコンテナ内の共有先のディレクトリのパス 

コンテナに指定のディレクトリが存在しない場合は新たに生成されます。

ちなみに、Docker Toolboxでは`/`直下のディレクトリは共有できないように

その場合は`/XXXXXXX/YYYYYYY`のように一つディレクトリを挟むようにしてください

#### WCOMMAND

`docker-compose up`でコンテナを起動した際に実行されるコマンドになります。

例では`python -V`が実行され、PythonのVersionが表示されるものになっています。
