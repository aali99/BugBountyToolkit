#!/bin/bash
## Automated Bug Bounty recon script dependency installer
## By Cas van Cooten

### NOTE: This installation script is deprecated by the implementation of the Dockerfile. Not all dependencies may automatically work.

for arg in "$@"
do
    case $arg in
        -h|--help)
        echo "BugBountyHunter Dependency Installer"
        echo " "
        echo "$0 [options]"
        echo " "
        echo "options:"
        echo "-h, --help                show brief help"
        echo "-t, --toolsdir            tools directory, defaults to '/opt'"
        echo ""
        echo "Note: If you choose a non-default tools directory, please adapt the default in the BugBountyAutomator.sh file or pass the -t flag to ensure it finds the right tools."
        echo " "
        echo "example:"
        echo "$0 -t /opt"
        exit 0
        ;;
        -t|--toolsdir)
        toolsDir="$2"
        shift
        shift
        ;;
    esac
done

if [ -z "$toolsDir" ]
then
    toolsDir="/opt"
fi

echo "[*] INSTALLING DEPENDENCIES IN \"$toolsDir\"..."

mkdir -p "$toolsDir"

apt install -y phantomjs xvfb dnsutils nmap



echo "[*] INSTALLING GO DEPENDENCIES (OUTPUT MAY FREEZE)..."
rm -rf /usr/local/go/
wget -q -O - https://git.io/vQhTU | bash
source /root/.bashrc
go get -u github.com/KathanP19/Gxss
go get -u github.com/lc/gau
go get -u github.com/tomnomnom/gf
go get -u github.com/jaeles-project/gospider
go get -u github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/haccer/subjack
go get -u github.com/tomnomnom/assetfinder
go get github.com/hakluke/hakrawler
go get -u github.com/OWASP/Amass/v3/...

echo "[*] INSTALLING RUSTSCAN..."

wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
dpkg -i rustscan_2.0.1_amd64.deb

echo "[*] INSTALLING GIT DEPENDENCIES..."

git clone https://github.com/hahwul/dalfox
cd dalfox
go install
go build

git clone https://github.com/chvancooten/BugBountyScanner
### Nuclei (Workaround -https://github.com/projectdiscovery/nuclei/issues/291)
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei.git
cd nuclei/v2/cmd/nuclei/ || { echo "Something went wrong"; exit 1; }
go build
mv nuclei /usr/local/bin/

### Nuclei templates
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/projectdiscovery/nuclei-templates.git
nuclei --update-templates 
### Gf-Patterns
cd "$toolsDir" || { echo "Something went wrong"; exit 1; }
git clone -q https://github.com/1ndianl33t/Gf-Patterns
mkdir ~/.gf
cp "$toolsDir"/Gf-Patterns/*.json ~/.gf

pip3 install telegram-send

echo "[*] SETUP FINISHED."


#sameh101010x
#-1001324393196
#1448371821:AAHLFabz4VA5QNfcBAtR5JEN3dtbU6s8v8c
