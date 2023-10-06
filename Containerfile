FROM golang:1.21

LABEL maintainer="@HubertStefanski"
LABEL description="A convenience container, enabling working with opentofu locally"

RUN git clone git@github.com:opentofu/opentofu.git && cd opentofu
RUN go mod init && go mod vendor

RUN go build -o /bin/opentofu ./cmd/main.go

FROM scratch
COPY --from=0 /bin/opentofu /bin/opentofu
ENTRYPOINT "/bin/opentofu"