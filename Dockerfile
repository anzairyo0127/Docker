# イメージ「ubuntu18.04」導入 製作者R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

# PythonVersion指定（Verを変える場合はこちらの値を変更してください）
ARG version="3.6.5"

# 環境名（マウント用のDirectoryの名前）
ARG envi="pytest"

# pyenvの環境変数PATH追加 
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# packageの追加
RUN apt update -y && apt install -y build-essential bzip2 zlib1g checkinstall curl gcc git libbz2-dev libreadline-dev libsqlite3-dev libssl-dev llvm make mercurial openssl unzip wget zlib1g-dev

# pyenvの導入
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv

# pyenv pythonダウンロード
RUN pyenv install ${version}

# virtualenvの導入
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git /.pyenv/plugins/pyenv-virtualenv

# マウントディレクトリの作成
RUN mkdir /${envi}

# pyenvとvirtualenvによる仮想環境の構築
RUN mkdir /project
RUN cd /project
RUN pyenv local ${version}

RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask

# pip更新とflaskの導入
RUN pip install -U pip
RUN pip install Flask

