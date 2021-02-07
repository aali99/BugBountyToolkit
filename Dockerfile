FROM ubuntu:16.04

LABEL maintainer="Alexis Ahmed/sameh"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit
    

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    wget \
    curl \
    make \
    python \
    #python-pip \
    python3 \
    python3-pip \
    dnsutils \
    net-tools \
    nano\
    nmap\
    && rm -rf /var/lib/apt/lists/*

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python-dnspython \
    libldns-dev \
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    libpcap-dev \
    python3 \
    fonts-powerline\
    hydra\
    screen\
    && rm -rf /var/lib/apt/lists/*


# configure python(s)
RUN python3 -m pip install --upgrade setuptools && pip3 install --upgrade setuptools 




# go
RUN cd /opt && \
    wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz && \
    tar -xvf go1.15.6.linux-amd64.tar.gz && \
    rm -rf /opt/go1.15.6.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}


# amass
RUN export GO111MODULE=on && \
    go get -v github.com/OWASP/Amass/v3/...


# Gotools
RUN go get -u github.com/tomnomnom/anew 
RUN go get github.com/jaeles-project/jaeles
RUN go get -u github.com/KathanP19/Gxss
RUN go get -u github.com/lc/gau
RUN go get -u github.com/tomnomnom/gf
RUN go get -u github.com/jaeles-project/gospider
RUN go get -u github.com/tomnomnom/qsreplace
RUN cd /root && git clone https://github.com/aali99/blindxss
RUN cd /root/blindxss
RUN chmod +x /root/blindxss/Auto-Scan-Xss.py
RUN mv /root/blindxss/git /root/blindxss/.git
RUN go get -u github.com/haccer/subjack
RUN go get -u github.com/tomnomnom/assetfinder
RUN go get github.com/hakluke/hakrawler
RUN go get -u github.com/ffuf/ffuf
RUN go get -u github.com/ethicalhackingplayground/bxss
RUN cd /root
RUN git clone https://github.com/dwisiswant0/crlfuzz &&  cd crlfuzz/cmd/crlfuzz&&  go build . && mv crlfuzz /usr/local/bin
RUN cd /root
RUN git clone https://github.com/projectdiscovery/httpx.git
RUN cd /root/httpx/cmd/httpx&&  go build
RUN mv /root/httpx/cmd/httpx/httpx /usr/local/bin/
#git clone https://github.com/hahwul/dalfox && cd dalfox && go install && go build
RUN go get -u github.com/hahwul/dalfox
RUN go get -u github.com/shenwei356/rush/
RUN cd /root && git clone https://github.com/m4ll0k/SecretFinder.git && cd SecretFinder && pip3 install -r requirements.txt && chmod +x SecretFinder.py
RUN cd  /root
RUN git clone https://github.com/maurosoria/dirsearch.git
RUN cd  /root
RUN git clone https://github.com/aali99/BugBountyScanner
RUN cd /root/BugBountyScanner && chmod +x rust.sh
RUN export GO111MODULE=on && \
    go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
RUN cd /opt/
RUN git clone -q https://github.com/projectdiscovery/nuclei-templates.git
RUN nuclei --update-templates
RUN cd /opt && git clone -q https://github.com/aali99/Gf-Patterns
RUN mkdir /root/.gf
RUN cp /opt/Gf-Patterns/*.json /root/.gf 
RUN cd /root
#RUN wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && dpkg -i rustscan_2.0.1_amd64.deb
RUN wget https://raw.githubusercontent.com/stamparm/DSSS/master/dsss.py  && chmod +x dsss.py
RUN pip3 install webscreenshot
RUN cd /root && git clone https://github.com/BountyStrike/Injectus && cd /root/Injectus && chmod +x * 
RUN cd /root/BugBountyScanner && git clone https://github.com/abdallah-elsharif/cve-2019-3396 && cd cve-2019-3396 && gem install bundler && bundle install && chmod +x cve-2019-3396.rb
RUN pip3 install uddup
RUN pip3 install telegram-send
#RUN pip3 install -r /root/Injectus/requirements.txt --user
