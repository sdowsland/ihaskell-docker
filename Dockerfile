FROM python:3

WORKDIR /usr/local/app

RUN apt-get update && apt-get install -y git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev

RUN curl -sSL https://get.haskellstack.org/ | sh

RUN git clone https://github.com/gibiansky/IHaskell

WORKDIR /usr/local/app/IHaskell

RUN pip install -r requirements.txt

RUN stack install gtk2hs-buildtools

RUN stack install --fast

RUN /root/.local/bin/ihaskell install --stack

RUN pip install jupyterlab

WORKDIR /usr/local/app/notebooks

CMD jupyter lab --port 9999 --ip=0.0.0.0 --allow-root