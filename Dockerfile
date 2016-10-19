FROM ubuntu

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y make g++ zlib1g-dev ncurses-dev vim git python3 python3-pip wget \
 && git clone https://github.com/sanger-pathogens/circlator \
 && cd circlator \
 && bash install_dependencies.sh \
 && export PATH=/circlator/build/SPAdes-3.7.1-Linux/bin:/circlator/build/samtools-1.3:/circlator/build/MUMmer3.23:/circlator/build/prodigal-2.6.2:/circlator/build/bwa-0.7.12:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && pip3 install --upgrade pip \
 && pip3 install circlator \
 && circlator progcheck \
 && apt-get install --purge make g++ zlib1g-dev ncurses-dev git vim wget \
 && apt-get autoclean

WORKDIR /data
ENTRYPOINT ["circlator"]
