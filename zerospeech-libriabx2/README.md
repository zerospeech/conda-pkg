# Conda Build Recipe for [zerospeech-libriabx2](https://pypi.org/project/zerospeech-libriabx2/)

A recipe allowing to build the conda package.


The source code of the package can be found on [github.com/zerospeech/libri-light-abx2](https://github.com/zerospeech/libri-light-abx2)



## Usage

1. install dependencies
```bash
$ conda install build anaconda
```

2. build package
```bash
$  conda build . -c pytorch -c conda-forge -c coml --output-folder dist
```

3. upload to anaconda
```bash
$ fs=$(shell find dist -name '*.tar.bz2')
$ anaconda upload -u $CHANEL_NAME ${fs} --force
```