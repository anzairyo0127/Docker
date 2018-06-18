# イメージ「ubuntu18.04」導入 製作者R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# 環境にあわせてここを変更してください

# PythonVersion指定
ARG version="3.6.5"

# マウントポイント(Ubuntu内の作業先）
ARG enviwork="/project"

# Command"pyenv"のPATHの値
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# pyenvの環境変数PATH追加 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# Pyenv用packageの追加
RUN apt update -y
RUN apt install -y \
make build-essential libssl-dev zlib1g-dev libbz2-dev git \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils
# pyenv、Gitよりダウンロード
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}
# pyenvに指定Pythonを導入
RUN pyenv install ${version}
# pyenv指定Pythonをprojectディレクトリ内で導入
RUN pyenv local ${version}

# virtualenvの導入
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ${pyenvpath}/plugins/pyenv-virtualenv
# flask導入用
RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask
# pip更新とflaskの導入
RUN pip install -U pip
RUN pip install Flask

# マウントディレクトリの作成
RUN mkdir /${enviwork}

