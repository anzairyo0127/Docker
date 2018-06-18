# �C���[�W�uubuntu18.04�v���� �����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# ���ɂ��킹�Ă�����ύX���Ă�������

# PythonVersion�w��
ARG version="3.6.5"

# �}�E���g�|�C���g(Ubuntu���̍�Ɛ�j
ARG enviwork="/project"

# Command"pyenv"��PATH�̒l
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# Pyenv�ppackage�̒ǉ�
RUN apt update -y
RUN apt install -y \
make build-essential libssl-dev zlib1g-dev libbz2-dev git \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils
# pyenv�AGit���_�E�����[�h
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}
# pyenv�Ɏw��Python�𓱓�
RUN pyenv install ${version}
# pyenv�w��Python��project�f�B���N�g�����œ���
RUN pyenv local ${version}

# virtualenv�̓���
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ${pyenvpath}/plugins/pyenv-virtualenv
# flask�����p
RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask
# pip�X�V��flask�̓���
RUN pip install -U pip
RUN pip install Flask

# �}�E���g�f�B���N�g���̍쐬
RUN mkdir /${enviwork}

