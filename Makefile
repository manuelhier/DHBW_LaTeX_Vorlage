NAME=main

all:
	latexmk -pdf ${NAME}.tex

clean:
	rm -f ${NAME}.aux ${NAME}.bbl ${NAME}.bcf ${NAME}.fdb_latexmk ${NAME}.fls ${NAME}.log ${NAME}.out ${NAME}.run.xml ${NAME}.blg ${NAME}.toc *\~

distclean: clean
	rm -f ${NAME}.pdf

watch:
	latexmk -pdf -pvc ${NAME}.tex

docker-build:
	docker build -t dhbw-latex . && docker run --rm -v $$(pwd):/work dhbw-latex
