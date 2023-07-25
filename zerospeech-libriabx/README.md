# Conda Build Recipe for [zerospeech-libriabx](https://pypi.org/project/zerospeech-libriabx/)

A recipe allowing to build the conda package.


The source code of the package can be found on [github.com/zerospeech/libri-light-abx](https://github.com/zerospeech/libri-light-abx)



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
$ fs=$(find dist -name '*.tar.bz2')
$ anaconda upload -u $CHANEL_NAME ${fs} --force
```