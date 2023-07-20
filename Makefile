fs=$(shell find dist -name '*.tar.bz2')
PYTHON_NUMPY_VER=\
	3.8:1.20\
	3.9:1.20\
	3.10:1.21\
	3.11:1.22


ifeq (, $(shell which conda))
	$(warning "Command conda was not found in current PATH, cannot build pkg")
endif

ifeq (, $(shell which anaconda))
	$(warning "Command anaconda was not found in current PATH, cannot upload pkgs")
endif

build-all: virtual-dataset zerospeech-libriabx zerospeech-libriabx2 zerospeech-tde zerospeech-benchmarks

upload: upload-pkg upload-env

zerospeech-benchmarks:
	conda build zerospeech-benchmarks -c conda-forge -c "${ANACONDA_USERNAME}" --output-folder dist

virtual-dataset:
	conda build virtual-dataset -c conda-forge --output-folder dist


# todo: migrate this to use conda-build-all
#:: https://github.com/conda-tools/conda-build-all
zerospeech-libriabx:
	$(foreach PYNP,$(PYTHON_NUMPY_VER), \
		$(eval PY = $(word 1,$(subst :, , $(PYNP)))) \
		$(eval NP = $(word 2,$(subst :, , $(PYNP)))) \
		conda build zerospeech-libriabx -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist --python=${PY} --numpy=${NP}; \
	)

# todo: migrate this to use conda-build-all
#:: https://github.com/conda-tools/conda-build-all
zerospeech-libriabx2:
	$(foreach PYNP,$(PYTHON_NUMPY_VER), \
		$(eval PY = $(word 1,$(subst :, , $(PYNP)))) \
		$(eval NP = $(word 2,$(subst :, , $(PYNP)))) \
		conda build zerospeech-libriabx2 -c conda-forge -c pytorch -c ${ANACONDA_USERNAME} --output-folder dist --python=${PY} --numpy=${NP}; \
	)

zerospeech-tde:
	conda build zerospeech-tde --output-folder dist

upload-env:
	@echo "pushing virtualenv environment.yml"


#anaconda -t "${ANACONDA_TOKEN}" upload -u "${ANACONDA_USERNAME}" "${fs[@]}" --force
upload-pkg:
	@echo "${fs}"

clean:
	rm -rf dist
	conda build purge


.PHONY: zerospeech-benchmarks upload virtual-dataset zerospeech-tde zerospeech-libriabx zerospeech-libriabx2 upload-pkg upload-env build-all