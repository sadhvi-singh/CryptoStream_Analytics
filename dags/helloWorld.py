from airflow.decorators import task
from airflow import DAG
from datetime import timedelta
from datetime import datetime

@task
def print_hello():
    print("hello!")
    return "hello!"


@task
def print_goodbye():
    print("goodbye!")
    return "goodbye!"


# Basic information necessary for all tasks
default_args = {
   'owner': 'keeyong',
   'email': ['keeyonghan@hotmail.com'],
   'retries': 1,
   'retry_delay': timedelta(minutes=3),
}

with DAG(
    dag_id = 'HelloWorld',
    start_date = datetime(2024,9,25),
    catchup=False,
    tags=['example'],
    schedule = '0 2 * * *',
    default_args=default_args
) as dag:

    # run two tasks in sequence
    print_hello() >> print_goodbye()
