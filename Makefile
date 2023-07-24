fs=$(shell find dist -name '*.tar.bz2')
ANACONDA_USERNAME=coml
LIBRISPEECH_VER = py3.8 py3.9 py3.10
LIBRISPEECH2_VER = py3.8 py3.9 py3.10


ifeq (, $(shell which conda))
	$(warning "Command conda was not found in current PATH, cannot build pkg")
endif

ifeq (, $(shell which anaconda))
	$(warning "Command anaconda was not found in current PATH, cannot upload pkgs")
endif


build-all: virtual-dataset zerospeech-tde zerospeech-libriabx zerospeech-libriabx2 zerospeech-benchmarks

upload: upload-pkg upload-env

zerospeech-benchmarks:
	conda build $@ -c conda-forge -c "${ANACONDA_USERNAME}" --output-folder dist

virtual-dataset:
	conda build $@ -c conda-forge --output-folder dist

zerospeech-libriabx:
	conda build $@ -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist

zerospeech-libriabx2:
	conda build $@ -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist

zerospeech-tde:
	conda build $@ --output-folder dist

upload-env:
	@echo "pushing virtualenv environment.yml"
	anaconda -t "${ANACONDA_TOKEN}" upload -u "${ANACONDA_USERNAME}" zrc-toolkit-env/environment.yaml

upload-pkg:
	@echo "Uploading: ${fs}"
	anaconda -t "${ANACONDA_TOKEN}" upload -u "${ANACONDA_USERNAME}" ${fs} --force

clean:
	rm -rf dist
	conda build purge


.PHONY: zerospeech-benchmarks virtual-dataset zerospeech-tde zerospeech-libriabx zerospeech-libriabx2 upload-pkg upload-env upload build-all