# �C���[�W�uubuntu18.04�v���� �����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

# PythonVersion�w��iVer��ς���ꍇ�͂�����̒l��ύX���Ă��������j
ARG version="3.6.5"

# �����i�}�E���g�p��Directory�̖��O�j
ARG envi="pytest"

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# package�̒ǉ�
RUN apt update -y && apt install -y build-essential bzip2 zlib1g checkinstall curl gcc git libbz2-dev libreadline-dev libsqlite3-dev libssl-dev llvm make mercurial openssl unzip wget zlib1g-dev

# pyenv�̓���
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv

# pyenv python�_�E�����[�h
RUN pyenv install ${version}

# virtualenv�̓���
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git /.pyenv/plugins/pyenv-virtualenv

# �}�E���g�f�B���N�g���̍쐬
RUN mkdir /${envi}

# pyenv��virtualenv�ɂ�鉼�z���̍\�z
RUN mkdir /project
RUN cd /project
RUN pyenv local ${version}

RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask

# pip�X�V��flask�̓���
RUN pip install -U pip
RUN pip install Flask

