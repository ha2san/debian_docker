FROM debian:latest


RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian-debug/ bullseye-debug main" >> /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.debian.org/debian stable main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y file parallel
RUN groupadd -r retro && useradd -r -g retro retro 
RUN apt-get install -y  python-dev \
git pip autoconf automake autopoint autotools-dev \
man-db po-debconf
RUN apt-get install clang -y

WORKDIR /home/retro 


RUN git clone https://github.com/HexHive/retrowrite.git /retrowrite
RUN ln -s /retrowrite/retrowrite /usr/bin/retrowrite

RUN pip install -r /retrowrite/requirements.txt



#COPY scripts/entrypoint.sh /etc/
#COPY scripts/flib.sh /etc/
COPY scripts/* /etc/

ENTRYPOINT ["/etc/entrypoint.sh"]
