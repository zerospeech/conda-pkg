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



build-all: virtual-dataset zerospeech-libriabx zerospeech-libriabx2 zerospeech-tde zerospeech-benchmarks

upload: upload-pkg upload-env

zerospeech-benchmarks:
	conda build $@ -c conda-forge -c "${ANACONDA_USERNAME}" --output-folder dist

virtual-dataset:
	conda build $@ -c conda-forge --output-folder dist


zerospeech-libriabx:
	$(foreach PYVER, $(LIBRISPEECH_VER), \
		conda build $@/${PYVER} -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist;\
	)

zrc-tst:
	@echo "$@"
	conda build zerospeech-libriabx/test -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist

zerospeech-libriabx2:
	$(foreach PYVER, $(LIBRISPEECH2_VER), \
		conda build $@/${PYVER} -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist;\
	)

zerospeech-tde:
	conda build $@ --output-folder dist

upload-env:
	@echo "pushing virtualenv environment.yml"


#anaconda -t "${ANACONDA_TOKEN}" upload -u "${ANACONDA_USERNAME}" "${fs[@]}" --force
upload-pkg:
	@echo "${fs}"

clean:
	rm -rf dist

#	conda build purge


.PHONY: zerospeech-benchmarks upload virtual-dataset zerospeech-tde zerospeech-libriabx zerospeech-libriabx2 upload-pkg upload-env build-all