# �C���[�W�uubuntu18.04�v���� �����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

#---------------------------------------------------#
# ���ɂ��킹�Ă�����ύX���Ă�������

# PythonVersion�w��
ARG version="3.6.5"

# �}�E���g�|�C���g(Ubuntu���̍�Ɛ�j
ARG enviwork="/pytest"

# Command"pyenv"��PATH�̒l
ARG pyenvpath="/.pyenv"

#---------------------------------------------------#

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT ${pyenvpath}
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Pyenv�ppackage�̒ǉ�

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

# pyenv�̓���
RUN git clone git://github.com/yyuu/pyenv.git ${pyenvpath}
# pyenv python�_�E�����[�h
RUN pyenv install ${version}
# �}�E���g�f�B���N�g���̍쐬
RUN mkdir /${enviwork}
# pyenv��virtualenv�ɂ�鉼�z���̍\�z
RUN mkdir /project
WORKDIR /project
RUN pyenv local ${version}


# virtualenv�̓���
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ${pyenvpath}/plugins/pyenv-virtualenv
# flask�����p
RUN pyenv virtualenv ${version} appflask
RUN pyenv local appflask
# pip�X�V��flask�̓���
RUN pip install -U pip
RUN pip install Flask

#�e�X�g�p���s
CMD python -V


