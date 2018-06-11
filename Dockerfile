# �C���[�W�uubuntu18.04�v�����@�����R.A
FROM ubuntu:18.04
MAINTAINER R.A "hogehoge@hogehoge.co.jp"

# pyenv�̊��ϐ�PATH�ǉ� 
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
# pyenv virtualenv�I�v�V����PATH�̒ǉ�
# ENV  

# package�̒ǉ�
RUN apt update -y  
RUN apt install -y gcc git curl make zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl openssl-devel


# pyenv�̓���
RUN git clone git://github.com/yyuu/pyenv.git /.pyenv

# pyenv python3.6.5���_�E�����[�h
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



