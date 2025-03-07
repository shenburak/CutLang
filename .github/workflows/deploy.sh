#!/bin/bash

cd ../../runs

wget http://www.hepforge.org/archive/cutlang/cms_opendata_ttbar.root
wget http://www.hepforge.org/archive/cutlang/atla_opendata_had_ttbar.root
wget -O delphes_events_ttbar.root https://docs.google.com/uc?export=download\&id=1P8Pv2hmV4QcMfNWmQTsuAkqIYcEzsuxt

source ../scripts/just_setup.sh

for i in $(ls |grep .adl); do
        echo "Testing $i:"
        echo "Using Bash Scripts"
        echo "With CMSOD"
        echo "CLA ./cms_opendata_ttbar.root CMSOD -i $i -e 1000 -v 500"
        CLA ./cms_opendata_ttbar.root CMSOD -i $i -e 1000 -v 500
        echo "With ATLASOD"
        echo "CLA ./atla_opendata_had_ttbar.root ATLASOD -i $i -e 1000 -v 500"
        CLA ./atla_opendata_had_ttbar.root ATLASOD -i $i -e 1000 -v 500
        echo "With DELPHES"
        echo "CLA ./delphes_events_ttbar.root DELPHES -i $i -e 1000 -v 500"
        CLA ./delphes_events_ttbar.root DELPHES -i $i -e 1000 -v 500
        #echo "Using Python Scripts"
        #echo "With CMSOD"
        #echo "python3 CLA.py ./cms_opendata_ttbar.root CMSOD -i $i -e 1000 -v 500"
        #python3 CLA.py ./cms_opendata_ttbar.root CMSOD -i $i -e 1000 -v 500
        #echo "With ATLASOD"
        #echo "python3 CLA.py ./atla_opendata_had_ttbar.root ATLASOD -i $i -e 1000 -v 500"
        #python3 CLA.py ./atla_opendata_had_ttbar.root ATLASOD -i $i -e 1000 -v 500
        #echo "With DELPHES"
        #echo "python3 CLA.py ./delphes_events_ttbar.root DELPHES -i $i -e 1000 -v 500"
        #python3 CLA.py ./delphes_events_ttbar.root DELPHES -i $i -e 1000 -v 500
done
