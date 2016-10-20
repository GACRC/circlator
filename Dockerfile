FROM ubuntu
MAINTAINER Paul Pham <docker@aquaron.com>

ENV circlator=/circlator\
 spades=SPAdes-3.7.1-Linux\
 samtools=samtools-1.3\
 mummer=MUMmer3.23\
 prodigal=prodigal-2.6.2\
 bwa=bwa-0.7.12\
 bin=/usr/local/bin\
 root=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV build=${circlator}/build
ENV PATH=${root}:${build}/${spades}/bin:${build}/${mummer}

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y make g++ zlib1g-dev ncurses-dev git python3 python3-pip wget csh \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && git clone https://github.com/sanger-pathogens/circlator \
 && cd ${circlator} \
 && bash install_dependencies.sh \
 && export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/circlator/build/SPAdes-3.7.1-Linux/bin:/circlator/build/MUMmer3.23 \
 && cd ${build} \
 && cp ${prodigal}/prodigal ${bin} \
 && cp ${bwa}/bwa ${bin} \
 && cd ${samtools}; make install; cd .. \
 && rm -rf *.gz *.bz2 \
 && pip3 install --upgrade --no-cache-dir pip \
 && pip3 install --no-cache-dir circlator \
 && circlator progcheck \
 && apt-get install --purge make g++ zlib1g-dev ncurses-dev git wget csh \
 && apt-get autoclean

WORKDIR /data
ENTRYPOINT ["circlator"]
