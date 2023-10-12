import datetime
import sqlite3
from flask import Flask, render_template, request, url_for, flash, redirect
from datetime import datetime
import os
import psycopg2
import boto3
from werkzeug.exceptions import abort

app = Flask(__name__)


def get_db_connection():
    db_host = os.getenv('DB_HOST')
    db_port = os.getenv('DB_PORT')
    db_name = os.getenv('DB_NAME')
    db_user = os.getenv('DB_USER')
    db_password = os.getenv('DB_PASSWORD')

    try:
        conn = psycopg2.connect(
            host=db_host,
            port=db_port,
            database=db_name,
            user=db_user,
            password=db_password
        )
        return conn
    except Exception as e:
        print(f"Error connecting to PostgreSQL: {str(e)}")
        return None


def cloudwatch_metric_push():
    print("PUSH STATS SET, SENDING METRICS")
    # os.putenv("export AWS_REGION=$(curl -s https://http://169.254.169.254/latest/meta-data/placement/region)")
    # os.system("export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)")

    print(f"AWS REGION {os.getenv('AWS_REGION')}")
    client = boto3.client("cloudwatch", region_name="us-east-1")

    client.put_metric_data(
        Namespace='Name of the Airflow DAG',
        MetricData=[
            {
                'MetricName': 'number_of_downloaded_rows',
                'Dimensions': [
                    {
                        'Name': 'Instance_ID',
                        'Value': 'i-0d0f33b6be7271391'
                    },
                ],
                'Value': 1,
                'Unit': 'Count'
            },
        ]
    )


@app.route('/')
def index():
    if os.getenv("PUSH_STATS") == "true":
        cloudwatch_metric_push()
    conn = get_db_connection()

    cur = conn.cursor()
    cur.execute('SELECT * FROM posts')
    posts = cur.fetchall()

    conn.close()
    return render_template('index.html', posts=posts)


@app.route('/create', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']

        if not title:
            flash('Title is required!')
        else:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('INSERT INTO posts (title, content) VALUES (%s, %s)',
                        (title, content))
            conn.commit()
            conn.close()
            return redirect(url_for('index'))

    return render_template('create.html')
