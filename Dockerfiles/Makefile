NAME = wipro/ocd
VERSION = 0.1.0

.PHONY: all \
	base java zmq chefclient javaservice jenkins nexus meteor orchestrator chefserver 
	tag_latest release clean

all:   base java zmq chefclient javaservice jenkins nexus meteor orchestrator chefserver	

# TODO: ran the proxy docker and expose 8000 - but can't connect to t, confirm all others can talk to it, check and publish the performance boost before/after.
# Check if "http://docs.docker.io/en/latest/use/port_redirection/#linking-a-container" is needed at all.  (if ... run ... -p 8000:8000 already
# exposed the port and since clients supposed to auto-discover anywhere on the network so they should be able to find.)
#proxy:
#	rm -rf proxy_image
#	cp -pR image proxy_image
#	echo proxy=1 >> proxy_image/buildconfig
#	docker build -t $(NAME)-proxy:$(VERSION) -rm proxy_image
#	docker run -d -t $(NAME)-proxy:$(VERSION) -p 8000:8000

# TODO: add orch code
#orch:
#	rm -rf orch_image
#	cp -pR image orch_image
#	echo proxy_client=1 >> orch_image/buildconfig
#	echo zeromq=1 >> orch_image/buildconfig
#	echo python=1 >> orch_image/buildconfig
#	docker build -t $(NAME)-orch:$(VERSION) -rm orch_image

# TODO: EXPOSE 3000 on running
#meteor:
#	rm -rf meteor_image
#	cp -pR image meteor_image
#	echo proxy_client=1 >> meteor_image/buildconfig
#	echo zeromq=1 >> meteor_image/buildconfig
#	echo nodejs=1 >> meteor_image/buildconfig
#	echo meteor=1 >> meteor_image/buildconfig
#	docker build -t $(NAME)-meteor:$(VERSION) -rm meteor_image
#
# TODO, cleanly add plugins and jobs from committed folders like other docker/jenkins samples.
# Did not use the existing jenkins docker images in public repo, no point in even investigating nor depending on
# any with the existance of an apt-get package.
#jenkins:
#	rm -rf jenkins_image
#	cp -pR image jenkins_image
#	echo proxy_client=1 >> jenkins_image/buildconfig
#	echo jenkins=1 >> jenkins_image/buildconfig
#	docker build -t $(NAME)-jenkins:$(VERSION) -rm jenkins_image
#
#full:
#	rm -rf full_image
#	cp -pR image full_image
#	echo proxy=1   >> full_image/buildconfig
#	echo zeromq=1  >> full_image/buildconfig
#	echo python=1  >> full_image/buildconfig
#	echo nodejs=1  >> full_image/buildconfig
#	echo meteor=1  >> full_image/buildconfig
#	echo jenkins=1 >> jenkins_image/buildconfig
#	docker build -t $(NAME)-full:$(VERSION) -rm full_image

#tag_latest:
#	docker tag $(NAME)-customizable:$(VERSION) $(NAME)-customizable:latest
#	docker tag $(NAME)-nodejs:$(VERSION) $(NAME)-nodejs:latest
#	docker tag $(NAME)-orch:$(VERSION) $(NAME)-orch:latest
#	docker tag $(NAME)-full:$(VERSION) $(NAME)-full:latest

#release: tag_latest
#	@if ! docker images $(NAME)-nodejs       | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-nodejs version $(VERSION) is not yet built. Please run 'make build'"; false; fi
#	@if ! docker images $(NAME)-orch         | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-orch version $(VERSION) is not yet built. Please run 'make build'"; false; fi
#	@if ! docker images $(NAME)-full         | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)-full version $(VERSION) is not yet built. Please run 'make build'"; false; fi
#	docker push $(NAME)-nodejs
#	docker push $(NAME)-orch
#	docker push $(NAME)-full
#	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

#clean:
#	rm -rf java_image
#	rm -rf customizable_image
#	rm -rf nodejs_image
#	rm -rf orch_image
#	rm -rf full_image

base:
	echo "Start time of $@: " `date`
	rm -rf base_image
	cp -pR image base_image
	echo baseinstall=1 >> base_image/buildconfig
	docker build -t $(NAME)-base:$(VERSION) -rm base_image
	echo "End time of $@: " `date`
java:
	echo "Start time of $@: " `date`
	rm -rf java_image
	cp -pR image java_image
	cp java_image/Dockerfile_base_simple java_image/Dockerfile
	echo javainstall=1 >> java_image/buildconfig	
	docker build -t $(NAME)-java:$(VERSION) -rm java_image
	echo "End time of $@: " `date`


zmq:
	echo "Start time of $@: " `date`
	rm -rf zmq_image
	cp -pR image zmq_image
	cp zmq_image/Dockerfile_base_simple zmq_image/Dockerfile
	echo zmqinstall=1 >> zmq_image/buildconfig
	docker build -t $(NAME)-zmq:$(VERSION) -rm zmq_image
	echo "End time of $@: " `date`


chefclient:
	echo "Start time of $@: " `date`
	rm -rf chefclient_image
	cp -pR image chefclient_image
	cp chefclient_image/Dockerfile_base_simple chefclient_image/Dockerfile
	echo chefclientinstall=1 >> chefclient_image/buildconfig
	docker build -t $(NAME)-chefclient:$(VERSION) -rm chefclient_image
	echo "End time of $@: " `date`


javaservice:
	echo "Start time of $@: " `date`
	rm -rf javaservice_image
	cp -pR image javaservice_image
	cp javaservice_image/Dockerfile_base_java javaservice_image/Dockerfile
	echo javaservice=1 >> javaservice_image/buildconfig
	docker build -t $(NAME)-javaservice:$(VERSION) -rm javaservice_image
	echo "End time of $@: " `date`


jenkins:
	echo "Start time of $@: " `date`
	rm -rf jenkins_image
	cp -pR image jenkins_image
	cp jenkins_image/Dockerfile_base_java jenkins_image/Dockerfile
	echo jenkinsinstall=1 >> jenkins_image/buildconfig
	docker build -t $(NAME)-jenkins:$(VERSION) -rm jenkins_image
	echo "End time of $@: " `date`


nexus:
	echo "Start time of $@: " `date`
	rm -rf nexus_image
	cp -pR image nexus_image
	cp nexus_image/Dockerfile_base_java nexus_image/Dockerfile
	echo nexusinstall=1 >> nexus_image/buildconfig
	docker build -t $(NAME)-nexus:$(VERSION) -rm nexus_image
	echo "End time of $@: " `date`



meteor:
	echo "Start time of $@: " `date`
	rm -rf meteor_image
	cp -pR image meteor_image
	cp meteor_image/Dockerfile_base_zmq meteor_image/Dockerfile
	echo meteorinstall=1 >> meteor_image/buildconfig
	docker build -t $(NAME)-meteor:$(VERSION) -rm meteor_image
	echo "End time of $@: " `date`


orchestrator:
	echo "Start time of $@: " `date`
	rm -rf orchestrator_image
	cp -pR image orchestrator_image
	cp orchestrator_image/Dockerfile_base_zmq orchestrator_image/Dockerfile
	echo orchinstall=1 >> orchestrator_image/buildconfig
	docker build -t $(NAME)-orchestrator:$(VERSION) -rm orchestrator_image
	echo "End time of $@: " `date`


clean:
	rm -rf java_image
	rm -rf java_image
	rm -rf zmq_image
	rm -rf javaservice_image
	rm -rf jenkins_image
	rm -rf nexus_image
	rm -rf meteor_image
	rm -rf orchestrator_image

chefserver:
	echo "Start time of $@: " `date`
	rm -rf chefserver_image
	cp -pR image chefserver_image
	cp chefserver_image/Dockerfile_for_server chefserver_image/Dockerfile
	docker build -t $(NAME)-chefserver:$(VERSION) -rm chefserver_image
	echo "End time of $@: " `date`
