from flask import Flask, render_template, request, url_for, flash, redirect
import os
import psycopg2

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


@app.route('/')
def index():
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
