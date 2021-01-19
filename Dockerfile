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
RUN go get -u github.com/tomnomnom/anew && \
    go get github.com/jaeles-project/jaeles && \
    jaeles config init && \
    go get -u github.com/KathanP19/Gxss && \
    go get -u github.com/lc/gau && \
    go get -u github.com/tomnomnom/gf && \
    go get -u github.com/jaeles-project/gospider && \
    go get -u github.com/tomnomnom/qsreplace && \
    cd ~ && git clone https://github.com/aali99/blindxss && cd blindxss&& chmod +x Auto-Scan-Xss.py && mv git .git && python3 Auto-Scan-Xss.py && \
    go get -u github.com/haccer/subjack && \
    go get -u github.com/tomnomnom/assetfinder && \
    go get github.com/hakluke/hakrawler && \
    go get -u github.com/ffuf/ffuf && \
    go get -u github.com/ethicalhackingplayground/bxss && \
    cd ~ && \
    git clone https://github.com/dwisiswant0/crlfuzz &&  cd crlfuzz/cmd/crlfuzz&&  go build . && mv crlfuzz /usr/local/bin && \
    cd ~ && \
    git clone https://github.com/projectdiscovery/httpx.git&&  cd httpx/cmd/httpx&&  go build&&  mv httpx /usr/local/bin/ &&  httpx -version && \
    cd $GOPATH/src/github.com/OWASP/Amass && \
    go install ./... && \
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && \
    dpkg -i rustscan_2.0.1_amd64.deb && \
    wget https://raw.githubusercontent.com/stamparm/DSSS/master/dsss.py  && chmod +x dsss.py && \
    git clone https://github.com/hahwul/dalfox && \
    cd dalfox && \
    go install && \
    go build && \
    cd  ~/ && \
    git clone https://github.com/chvancooten/BugBountyScanner && \
    cd ~/BugBountyScanner && \
    wget https://raw.githubusercontent.com/aali99/BugBountyScanner/master/.env && \
    rm -rf .env.example && \
    git clone -q https://github.com/projectdiscovery/nuclei.git && \
    cd nuclei/v2/cmd/nuclei/ && \
    go build && \
    mv nuclei /usr/local/bin && \
    cd /opt && \
    git clone -q https://github.com/projectdiscovery/nuclei-templates.git && \
    nuclei --update-templates && \
    cd /opt && \
    git clone -q https://github.com/1ndianl33t/Gf-Patterns && \
    mkdir ~/.gf && \
    cp /opt/Gf-Patterns/*.json ~/.gf 
