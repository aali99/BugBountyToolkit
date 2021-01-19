FROM ubuntu:18.04

LABEL maintainer="Alexis Ahmed"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir ${HOME}/wordlists

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    wget \
    tzdata \
    curl \
    make \
    python \
    python-pip \
    python3 \
    python3-pip \
    dnsutils \
    net-tools \
    nano\
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
    python3.7 \
    fonts-powerline\
    && rm -rf /var/lib/apt/lists/*

# tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools && python3.7 -m pip install --upgrade setuptools && \
    easy_install -U shodan




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
RUN cd ~ && git clone https://github.com/aali99/blindxss && cd blindxss&& chmod +x Auto-Scan-Xss.py && mv git .git && python3 Auto-Scan-Xss.py
RUN go get -u github.com/haccer/subjack
RUN go get -u github.com/tomnomnom/assetfinder
RUN go get github.com/hakluke/hakrawler
RUN go get -u github.com/ffuf/ffuf
RUN go get -u github.com/ethicalhackingplayground/bxss
RUN cd ~
RUN git clone https://github.com/dwisiswant0/crlfuzz &&  cd crlfuzz/cmd/crlfuzz&&  go build . && mv crlfuzz /usr/local/bin
RUN cd ~
RUN git clone https://github.com/projectdiscovery/httpx.git&&  cd httpx/cmd/httpx&&  go build&&  mv httpx /usr/local/bin/ &&  httpx -version
RUN cd $GOPATH/src/github.com/OWASP/Amass
RUN go install ./...
RUN wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
RUN dpkg -i rustscan_2.0.1_amd64.deb
RUN wget https://raw.githubusercontent.com/stamparm/DSSS/master/dsss.py  && chmod +x dsss.py
RUN git clone https://github.com/hahwul/dalfox
RUN cd dalfox
RUN go install
RUN go build
RUN cd  ~/
RUN git clone https://github.com/chvancooten/BugBountyScanner
RUN cd ~/BugBountyScanner
RUN wget https://raw.githubusercontent.com/aali99/BugBountyScanner/master/.env
RUN rm -rf .env.example
RUN git clone -q https://github.com/projectdiscovery/nuclei.git
RUN cd nuclei/v2/cmd/nuclei/
RUN go build
RUN mv nuclei /usr/local/bin
RUN cd /opt
RUN git clone -q https://github.com/projectdiscovery/nuclei-templates.git
RUN nuclei --update-templates
RUN cd /opt
RUN git clone -q https://github.com/1ndianl33t/Gf-Patterns
RUN mkdir ~/.gf
RUN cp /opt/Gf-Patterns/*.json ~/.gf 
