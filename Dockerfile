# �C���[�W�uubuntu18.04�v�����@�����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

# PythonVersion�w��
# RUN PYVER=3.6.5

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

###RUN echo 'export PYENV_ROOT="/.pyenv"' >>  /etc/profile.d/pyenv.sh
###RUN echo 'export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/pyenv.sh

# virtualenv�̊��ϐ��ǉ�
# ENV  

# package�̒ǉ�
RUN apt update -y && apt install -y wget curl git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev bzip2 zlib1g build-essential checkinstall mercurial unzip zlib1g-dev llvm 

# pyenv�̓���
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv

### source���s
###RUN source /etc/profile.d/pyenv.sh

# pyenv python�_�E�����[�h
RUN pyenv install 3.6.5

# virtualenv�̓���
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git /.pyenv/plugins/pyenv-virtualenv

# pyenv��virtualenv�ɂ�鉼�z���̍\�z
RUN mkdir /project
RUN cd /project
RUN pyenv local 3.6.5
RUN pyenv virtualenv 3.6.5 365-flask

RUN pyenv local 365-flask
RUN pip install Flask



