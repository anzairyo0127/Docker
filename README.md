# クイックスタート

## 編集が必要なところ

`.env.example`を`.env`にリネームすること。

`.env`の中身を編集すること。

## ファイルを置く

`Dockerfile` `docker-compose` `.env.example`を

``c:\users\*****\[好みのディレクトリ名]``以下に置く


## Docker Toolboxを起動し、imageとcontainerを作成

`CMD`

```
cd  c:\users\*****\[好みのディレクトリ名] 

docker-compose up

```


# Docker物置

Dockerで使用するファイルをアップロードしています。

- Dockerfile
- docker-compose
- .env.example(Docker Composeで使用)

## Dockerfileの使い方

Dockerfileはimageを生成するときに使用します。

後にdocker-composeにて使用します。

containerとして使用するLinuxのディストリビューションや、packageなどは

ここを編集して自分の好みのものを作ってください。


なお、Dockerfile単体でimageを生成することも可能です。

カレントディレクトリを`Dockerfileの置いてある場所`にした状態で

以下のcommandを打ってください。

```

docker build -t [image名] .

```

これで生成されます。

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

#### FlaskのVersion指定

```
# FlaskのVersion指定
ARG fver="1.0.2"
```

このDockerfileで導入されるFlaskのVersionを指定することができます。

なお、pipにて導入されます。

FlaskのVer1.0.1を導入したい場合は`ARG fver="1.0.1"`と記載。


## docker-composeの使い方

docker-composeはcontainerを生成します。

Dockerfileを同じディレクトリに入れておくことで、

Dockerfileを使用してimage生成し、それからcontainerを生成することもできます。

今回はimageをDockerfileで生成するようにしています。

カレントディレクトリをdocker-compose.ymlのある場所にした状態で

``` docker-compose up ```

とコマンドをたたいてください。



docker-composeはyml形式ですので、メモ帳でもVSCodeでもviでも開けます。

具体的な値は`.env`の変数を変更して使用します。

もちろん、このファイルに直接書き込んでも動作しますが、基本的には`.env`を編集してください。

`.env.example`を一緒にコミットしますので、`コピー＆ペースト`ですとか`cp .env.example .env`で

コピーして使用してください。なお、`.env`は`.gitignore`にてアップロードされないようになってます。


## .env.exampleの使い方

docker-composeの中身の変数がこちらに記載されています。

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

##### マウントに係る注意点

(1)コンテナ側　`/`直下のディレクトリには共有できない

Docker Toolboxでは`/`直下のディレクトリは共有できないようなので

その場合は`/XXXXXXX/YYYYYYY`のように一つディレクトリを挟むようにしてください

(2)ホストOS側 `c:\users`以下のフォルダでないと共有できない

VirtualBoxの関係か、`c:\users`以下のフォルダでないと共有できないようです。

#### WCOMMAND

`docker-compose up`でコンテナを起動した際に実行されるコマンドになります。

例では`python -V`が実行され、PythonのVersionが表示されるものになっています。
