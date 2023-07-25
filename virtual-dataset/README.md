# Conda Build Recipe for [virtual-dataset](https://pypi.org/project/virtual-dataset/)

A recipe allowing to build the conda package.


The source code of the package can be found on [github.com/nhamilakis/virtual-dataset](https://github.com/nhamilakis/virtual-dataset)



## Usage

1. install dependencies
```bash
$ conda install build anaconda
```

2. build package
```bash
$  conda build . -c conda-forge --output-folder dist
```

3. upload to anaconda
```bash
$ fs=$(find dist -name '*.tar.bz2')
$ anaconda upload -u $CHANEL_NAME ${fs} --force
```