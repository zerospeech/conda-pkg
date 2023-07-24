# Zerospeech conda repository

conda package building recipes


## Usage

- Install dependencies: `conda install build anaconda` && `conda install conda-build-all --channel conda-forge`
- Run pkg build: `make build-all`
- Define an env variable with the anaconda token : `export ANACONDA_TOKEN=XXXXXXXXXX`
- Upload to anaconda cloud `make upload`
