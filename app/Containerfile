FROM registry.access.redhat.com/ubi9/ubi:9.2-755

WORKDIR /
COPY src src
COPY requirements.txt requirements.txt
ENV DNF_OPTS="--setopt=install_weak_deps=False --setopt=tsflags=nodocs"
RUN dnf install -y python3-devel \
 && dnf clean all -y
RUN pip install flask
RUN pip install -r requirements.txt

#EXPOSE 80
#EXPOSE 443
EXPOSE 5000

ENV FLASK_APP=src/example_package/entrypoint.py
CMD ["flask", "run", "-p", "5000", "--host", "0.0.0.0"]
