# イメージ「ubuntu18.04」導入 製作者R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# 環境にあわせてここの領域を変更してください

# PythonVersion指定
ARG version="3.6.5"

# ホストOSの作業ディレクトリ（フォルダ）
ARG hostwork="/C/Users/RyoAnzai/Documents/www"

# 環境名（マウントポイント）
ARG enviwork="pytest"

# Command"pyenv"のPATHの値
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# PythonRun実行時のPATH追加
# ENV WORKPOINT ${hostwork}

# pyenvの環境変数PATH追加 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# packageの追加
RUN apt update -y && \
    apt install -y \
    gcc \
    git \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    make \
    openssl \

# pyenvの導入
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}

# pyenv pythonダウンロード
RUN pyenv install ${version}

# マウントディレクトリの作成
RUN mkdir /${enviwork}

# pyenvとvirtualenvによる仮想環境の構築
RUN mkdir /project
RUN cd /project
RUN pyenv local ${version}

# Localとcontainerの領域のマウント実施
VOLUME ["${hostwork}","/${enviwork}"] 

# container実行のcommand
CMD python /${enviwork}/hello.py
