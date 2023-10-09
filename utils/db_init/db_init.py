import os
import psycopg2

db_host = os.getenv('DB_HOST')
db_port = os.getenv('DB_PORT')
db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')


def get_connection():
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


connection = get_connection()
cur = connection.cursor()

with open(f'{os.getcwd()}/schema.sql') as f:
    cur.execute(f.read())

for i in range(0, 20):
    cur.execute('INSERT INTO posts (title, content) VALUES (%s, %s)',
                (f'post number:{i}', 'Lorem Ipsum Dolor Sit Amet'))

connection.commit()
connection.close()
