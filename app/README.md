# Example Flask App

A simple Python Flask App inspired
by https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3.
To represent a "real-worldish" deployment of a user interface and a database back end.

I am aware of some of the ugliness of the code here, however, this isn't a concern as this application is only supposed
to serve as a simple web UI to demonstrate deployed infrastructure and relevant networking for a Cloud Architecture
assignment.

## Requirements
### Postgres

The deployment expects a running postgres database, you can deploy it using the following commands

```shell
podman pull postgres &&\
 podman run --name postgresql \
 -e POSTGRES_DB=demo-db \
 -e POSTGRES_USER=demo \
 -e POSTGRES_PASSWORD=demo123 \
 -p 5432:5432 \
 -v /data:/var/lib/postgresql/data \
 -d postgres:latest
```

### DB Initialization

Optionally, you can initialize the databse with some mock data using the following:

```shell
podman pull quay.io/hstefans/db_init:latest && \
 podman run -e DB_NAME=demo-db \
 -e DB_USER=demo \
 -e DB_PASSWORD=demo123 \
 -e DB_HOST=<POSTGRES_ADDRESS_HERE> \
 -e DB_PORT=5432 quay.io/hstefans/db_init:latest
```

## Run

### Flask App

```shell
podman run -it -p 5000:5000 \
 --network host \
 -e DB_NAME=demo-db \
 -e DB_USER=demo \
 -e DB_PASSWORD=demo123 \
 -e DB_HOST=<POSTGRES ADDRESS HERE> \
 -e DB_PORT=5432 quay.io/hstefans/example_flask_app:latest
```
