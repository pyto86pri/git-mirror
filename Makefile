TEMPLATE_FILE := template.yml
SAM_FILE := sam.yml

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
	-mv output/$(SAM_FILE) $(SAM_FILE)
	-rm -rf output .aws .aws-sam

deploy:
	sam deploy \
		--template-file $(SAM_FILE) \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM
	-rm $(SAM_FILE)

destroy:
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME)
