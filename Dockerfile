FROM ubuntu:16.04
#shared libraries and dependencies
RUN apt update && \
    apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils && \
    apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
#BerkleyDB for wallet support
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev

RUN apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev

COPY ./cnccoin /cnccoin
WORKDIR /cnccoin


#RUN make clean
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

#CMD ["tail", "-F", "/dev/null"]

CMD ["cnccoind", "--printtoconsole"]
