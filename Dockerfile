# イメージ「ubuntu18.04」導入　製作者R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

# PythonVersion指定
# RUN PYVER=3.6.5

# pyenvの環境変数PATH追加 
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

###RUN echo 'export PYENV_ROOT="/.pyenv"' >>  /etc/profile.d/pyenv.sh
###RUN echo 'export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/pyenv.sh

# virtualenvの環境変数追加
# ENV  

# packageの追加
RUN apt update -y && apt install -y wget curl git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev bzip2 zlib1g build-essential checkinstall mercurial unzip zlib1g-dev llvm 

# pyenvの導入
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv

### source実行
###RUN source /etc/profile.d/pyenv.sh

# pyenv pythonダウンロード
RUN pyenv install 3.6.5

# virtualenvの導入
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git /.pyenv/plugins/pyenv-virtualenv

# pyenvとvirtualenvによる仮想環境の構築
RUN mkdir /project
RUN cd /project
RUN pyenv local 3.6.5
RUN pyenv virtualenv 3.6.5 365-flask

RUN pyenv local 365-flask
RUN pip install Flask



