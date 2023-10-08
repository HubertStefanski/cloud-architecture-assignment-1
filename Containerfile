FROM registry.access.redhat.com/ubi9/ubi:9.2-755

LABEL maintainer="@HubertStefanski"
LABEL description="A convenience container, enabling working with opentofu locally"

RUN curl -L https://github.com/opentofu/opentofu/releases/download/v1.6.0-alpha2/tofu_1.6.0-alpha2_linux_amd64.zip \
    --output opentofu.zip &&\
    unzip opentofu.zip -d opentofu &&\
    mv opentofu/tofu /bin/tofu &&\
    rm opentofu opentofu.zip -rf \

ENTRYPOINT "/bin/tofu"