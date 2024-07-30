FROM debian:stable-slim
ARG FPC_COMPILER_VERSION_OLD="3.2.2"
WORKDIR /usr
RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN apt upgrade&&apt update&&echo 'Y'| apt install wget gcc git make cmake 
RUN echo 'Y'| apt install binutils-aarch64-linux-gnu binutils-arm-linux-gnueabihf binutils-common binutils-i686-linux-gnu  binutils-powerpc64le-linux-gnu binutils-riscv64-linux-gnu binutils-s390x-linux-gnu binutils-x86-64-linux-gnu libbinutils&&apt clean
ARG ARCHIVE_NAME="fpc-${FPC_COMPILER_VERSION_OLD}.x86_64-linux"
RUN wget "https://downloads.sourceforge.net/project/freepascal/Linux/${FPC_COMPILER_VERSION_OLD}/${ARCHIVE_NAME}.tar" -O fpc.tar
RUN tar xf "fpc.tar"  
RUN ls $FPC_FOR_BUILD -a
RUN rm -f "fpc.tar" 
#install fpc from tar.gz
RUN cd $ARCHIVE_NAME&&echo -e '/usr\nN\nN\nN\n' | su root ./install.sh
#Remove directory and fpc check
RUN cd /usr&&rm -rf $ARCHIVE_NAME 
ENV FPC_DIR /usr/lib/fpc/${FPC_COMPILER_VERSION_OLD}
RUN ls -a $FPC_DIR
ENV COMPILER_NAME $FPC_DIR/ppcx64
RUN $COMPILER_NAME -h
