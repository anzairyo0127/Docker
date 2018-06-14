# �C���[�W�uubuntu18.04�v���� �����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# ���ɂ��킹�Ă����̗̈��ύX���Ă�������

# PythonVersion�w��
ARG version="3.6.5"

# �z�X�gOS�̍�ƃf�B���N�g���i�t�H���_�j
ARG hostwork="/C/Users/RyoAnzai/Documents/www"

# �����i�}�E���g�|�C���g�j
ARG enviwork="pytest"

# Command"pyenv"��PATH�̒l
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# PythonRun���s����PATH�ǉ�
# ENV WORKPOINT ${hostwork}

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# package�̒ǉ�
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

# pyenv�̓���
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}

# pyenv python�_�E�����[�h
RUN pyenv install ${version}

# �}�E���g�f�B���N�g���̍쐬
RUN mkdir /${enviwork}

# pyenv��virtualenv�ɂ�鉼�z���̍\�z
RUN mkdir /project
RUN cd /project
RUN pyenv local ${version}

# Local��container�̗̈�̃}�E���g���{
VOLUME ["${hostwork}","/${enviwork}"] 

# container���s��command
CMD python /${enviwork}/hello.py
