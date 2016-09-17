VERSION = 1.6.1
ORGANIZATION=apacheimages
REPOSITORY=couchdb
PORT=5984

all: build push
	;
	
build: Dockerfile
	docker build -t ${ORGANIZATION}/${REPOSITORY}:${VERSION} .

push:
	#docker push ${ORGANIZATION}/${REPOSITORY}:${VERSION}
	git add Dockerfile
	git push origin ${VERSION}
	
shell:
	docker run --name ${REPOSITORY} -it --rm -p ${PORT}:${PORT} ${ORGANIZATION}/${REPOSITORY}:${VERSION} /bin/sh

run:
	docker run --name ${REPOSITORY} --rm -p ${PORT}:${PORT} ${ORGANIZATION}/${REPOSITORY}:${VERSION} 
