# Example Flask App

A simple Python Flask App inspired
by https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3.
To represent a "real-worldish" deployment of a user interface and a database back end.

# Build and Run

Set the `SQL_DB_ADDR` environment variable to a databse.db file location or the URL of the SQL database

```shell
 podman build -t <container_host>.io/<repo>/example_flask_app:latest .  
```

```shell
 podman run -it -p 5000:5000 --network host -v $(pwd)/database.db:/mnt/database.db:Z -e 'SQL_DB_ADDR=/mnt/database.db' quay.io/hstefans/example_flask_app:latest
```