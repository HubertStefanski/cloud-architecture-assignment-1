# Example Flask App

A simple Python Flask App inspired
by https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3.
To represent a "real-worldish" deployment of a user interface and a database back end.

# Build and Run

```shell
 podman build -t <container_host>.io/<repo>/example_flask_app:latest .  
```

```shell
podman run -it -p 5000:5000 --network host quay.io/hstefans/example_flask_app:latest
```