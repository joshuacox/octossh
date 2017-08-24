all: build clean run logs

build:
	docker build -t local/octossh .

run: .octossh.cid

.octossh.cid:
	docker run \
	--name octossh \
	--cidfile .octossh.cid \
	-it -d \
	--env KEY_URL=https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/keys \
	local/octossh

enter:
	@-docker exec -it `cat .octossh.cid` /bin/sh

logs:
	@-docker logs -f `cat .octossh.cid`

kill: 
	@-docker kill `cat .octossh.cid`

rm:
	@-docker rm `cat .octossh.cid`
	@-rm .octossh.cid

clean: kill rm
