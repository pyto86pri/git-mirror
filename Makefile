IMAGE := backlog-git-webhook.$(shell pwd | md5sum | awk '{print $$1}')
TEMPLATE_FILE := template.yml
SAM_FILE := sam.yml

all:

clean:
	-rm $(SAM_FILE)

install:
	pipenv sync --dev

test:
	cd tests && \
	bats test-handler.bats

e2e:
	pipenv run sam local invoke --debug \
		-e tests/event.json \
		-n tests/env-vars.json

validate:
	pipenv run sam validate \
		--template $(TEMPLATE_FILE)

package:
	-docker image rm $(IMAGE)
	docker build -t $(IMAGE) --build-arg BUCKET=$(BUCKET) . -q
	docker run \
		-v $(shell pwd):/home/samcli/work/ \
		-v $(HOME)/.aws/:/home/samcli/.aws/ \
		--rm \
		$(IMAGE)
	-mv output/$(SAM_FILE) $(SAM_FILE)
	-rm -rf output

deploy:
	pipenv run sam deploy \
		--template-file $(SAM_FILE) \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM
	-rm $(SAM_FILE)

destroy:
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME)
