FROM python:3.7.2-slim-stretch

LABEL maintainer="Rainist Engineering <engineering@rainist.com>"

WORKDIR /note

RUN apt-get update && \
    apt-get install -y wget unzip

ARG ANSIBLE_VERSION=2.7.6
RUN pip install ansible==${ANSIBLE_VERSION}

ARG TERRAFORM_VERSION=0.11.11
ARG TERRAFORM_RELEASE=terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN wget -qO /note/${TERRAFORM_RELEASE} \
    https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_RELEASE} --show-progress && \
    unzip -qq /note/${TERRAFORM_RELEASE} && \
    rm /note/${TERRAFORM_RELEASE} && \
    mv /note/terraform /usr/local/bin && \
    chmod +x /usr/local/bin/terraform && \
    echo "complete -C /usr/local/bin/terraform terraform" > ~/.bashrc

CMD ["bash"]
