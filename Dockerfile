# イメージ「ubuntu18.04」導入 製作者R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# 環境にあわせてここを変更してください

# PythonVersion指定
ARG version="3.6.5"

# マウントポイント(Ubuntu内の作業先）
ARG enviwork="/pytest"

# Command"pyenv"のPATHの値
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# pyenvの環境変数PATH追加 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Pyenv用packageの追加

RUN apt update -y && \
apt install -y \
build-essential \
bzip2 \
checkinstall \
curl \
gcc \
git \
libbz2-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
llvm \
make \
mercurial \
openssl \
unzip \
wget \
zlib1g \
zlib1g-dev

# pyenvの導入
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}
# pyenv pythonダウンロード
RUN pyenv install ${version}
# マウントディレクトリの作成
RUN mkdir /${enviwork}
# pyenvとvirtualenvによる仮想環境の構築
RUN mkdir /project
WORKDIR /project
RUN pyenv local ${version}


# virtualenvの導入
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ${pyenvpath}/plugins/pyenv-virtualenv
# flask導入用
RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask
# pip更新とflaskの導入
RUN pip install -U pip
RUN pip install Flask

#テスト用実行
CMD python -V


