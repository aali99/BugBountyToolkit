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
    gcc \
    git \
    wget \
    awscli \
    curl \
    make \
    python \
    python-pip \
    python3 \
    python3-pip \
    zsh\
    nano\
    && rm -rf /var/lib/apt/lists/*

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    # dirb
    python-pycurl \
    # knock
    python-dnspython \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    # masscan
    libpcap-dev \
    # theharvester
    python3.7 \
    # joomscan
    libwww-perl \
    # hydra
    # dnsr
    # zsh
    powerline\
    # zsh
    fonts-powerline\
    && rm -rf /var/lib/apt/lists/*

# tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools && python3.7 -m pip install --upgrade setuptools


# XSStrike
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/toolkit/XSStrike/xsstrike.py /usr/local/bin/xsstrike
    
RUN mkdir -p /opt

RUN apt install -y phantomjs xvfb dnsutils nmap




RUN echo "[*] INSTALLING GO DEPENDENCIES (OUTPUT MAY FREEZE)..." 
RUN wget -q -O - https://git.io/vQhTU | bash&&source "~/.bashrc" &&source "~/.bashrc"







RUN go get -u github.com/tomnomnom/anew
RUN go get github.com/jaeles-project/jaeles
RUN jaeles config init

RUN go get -u github.com/KathanP19/Gxss
RUN go get -u github.com/lc/gau
RUN go get -u github.com/tomnomnom/gf
RUN go get -u github.com/jaeles-project/gospider
RUN go get -u github.com/tomnomnom/qsreplace

RUN cd ~ &&git clone https://github.com/aali99/blindxss &&cd blindxss&&chmod +x Auto-Scan-Xss.py &&ln -sf git .git &&python3 Auto-Scan-Xss.py
RUN go get -u github.com/haccer/subjack
RUN go get -u github.com/tomnomnom/assetfinder
RUN go get github.com/hakluke/hakrawler
RUN go get -u github.com/OWASP/Amass/v3/...

RUN go get -u github.com/ffuf/ffuf
RUN go get -u github.com/ethicalhackingplayground/bxss
RUN cd ~
RUN git clone https://github.com/dwisiswant0/crlfuzz && cd crlfuzz/cmd/crlfuzz&& go build . &&ln -sf crlfuzz /usr/local/bin
RUN cd ~
RUN git clone https://github.com/projectdiscovery/httpx.git&& cd httpx/cmd/httpx&& go build&& ln -sf httpx /usr/local/bin/&& httpx -version
RUN cd $GOPATH/src/github.com/OWASP/Amass
RUN go install ./...


RUN apt install screen 
RUN apt-get install jq

RUN pip install --upgrade httpie
RUN pip3 install telegram-send

RUN echo "[*] INSTALLING RUSTSCAN..."
RUN cd ~
RUN wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
RUN dpkg -i rustscan_2.0.1_amd64.deb



RUN wget https://raw.githubusercontent.com/stamparm/DSSS/master/dsss.py &&chmod +x dsss.py

RUN echo "[*] INSTALLING GIT DEPENDENCIES..."
RUN cd ~
RUN git clone https://github.com/KathanP19/JSFScan.sh
RUN cd ~/JSFScan*
RUN chmod +x install.sh 
RUN chmod +x JSFScan.sh
RUN ./install.sh



RUN git clone https://github.com/hahwul/dalfox
RUN cd dalfox
RUN go install
RUN go build



RUN cd ~
RUN git clone https://github.com/aali99/scrpt
RUN cd ~/scrpt
RUN cp raftseclist.txt ~/
RUN cd ~
RUN git clone https://github.com/chvancooten/BugBountyScanner

RUN cd ~/BugBountyScanner/
RUN wget https://raw.githubusercontent.com/aali99/BugBountyScanner/master/.env
RUN rm -rf .env.example
RUN echo "fitbit.com,elastifile.com,spokeo.com,asana.biz,asana.plus,app.asana.com,form.asana.com,bina.com,intermune.com,genia.com,roche-applied-science.com,accu-chek.com,coaguchek.com,roche-diagnostics.fr,roche-diagnostics.co.in,roche-diagnostics.com,cobas.com,accu-chekinsulinpumps.com,rocheindia.com,roche.co.uk,lucentisdirect.com,lucentis.com,ariosadx.com,kapabiosystems.com,navify.com,hyperdesign.com,mysugr.com,viewics.com,sparktx.com,clinical-services.net,foundationmedicine.com,foundationmedicine.ph,stratosgenomics.com,roche.com,ventana.com,sameh23.jfrog.com,gene.com" >programs.txt
RUN cp ~/scrpt/ghgh.sh ./
RUN chmod +x ghgh.sh


RUN cd /opt || { echo "Something went wrong"&& exit 1&& }
RUN git clone -q https://github.com/projectdiscovery/nuclei.git
RUN cd nuclei/v2/cmd/nuclei/ || { echo "Something went wrong"&& exit 1&& }
RUN go build
RUN ln -sf nuclei /usr/local/bin/


RUN cd /opt || { echo "Something went wrong"&& exit 1&& }
RUN git clone -q https://github.com/projectdiscovery/nuclei-templates.git
RUN nuclei --update-templates 

RUN cd /opt || { echo "Something went wrong"&& exit 1&& }
RUN git clone -q https://github.com/1ndianl33t/Gf-Patterns
RUN mkdir ~/.gf
RUN cp /opt/Gf-Patterns/*.json ~/.gf

