TEMPLATE_FILE := template.yml
SAM_FILE := output/sam.yml
BUCKET := local-artifacts-opkl
STACK_NAME := test-git-mirror


all:

clean:
	-rm $(SAM_FILE)

install:

test:
	cd tests && \
	bats test-handler.bats

validate:
	sam validate \
		--template $(TEMPLATE_FILE)

package:
	docker run \
		-v $(shell pwd):/home/samcli/ \
		-v $(HOME)/.aws/:/home/samcli/.aws/ \
		--rm \
		$(shell docker build --build-arg BUCKET=$(BUCKET) . -q)

deploy:
	sam deploy \
		--template-file $(SAM_FILE) \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM

destroy:
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME)
