FROM pahud/aws-sam-cli:latest

ARG BUCKET
ENV BUCKET=$BUCKET

ENV TEMPLATE_FILE=template.yml
ENV SAM_FILE=output/sam.yml

COPY . .

CMD cd src && \
	sudo chmod 755 function.bash bootstrap
CMD mkdir output && \
	sam package \
		--template-file $TEMPLATE_FILE \
		--s3-bucket $BUCKET \
		--output-template-file $SAM_FILE