import pandas as pd
import numpy as np
from sqlalchemy import create_engine

engine = create_engine('mysql+pymysql://root:@127.0.0.1:3306/db')
flights = pd.read_sql_table('Flights', engine)
flight_arrivals = pd.read_sql_table('FlightArrivals', engine)
drivers = pd.read_sql_table('Drivers', engine)
tasks = pd.read_sql_table('Tasks', engine)

def get_available_driver():
    assigned_drivers = tasks[tasks['is_completed'] == 0]['driver_id'].unique()
    available_driver = drivers[~drivers['driver_id'].isin(assigned_drivers)].iloc[0]
    return available_driver

def create_first_task_for_flight_arrival(flight_arrival):
    task = {
        'arrival_id': flight_arrival['arrival_id'],
        'driver_id': get_available_driver()['driver_id'],
        'is_completed': 0,
        'task_id': 1,
    }
    tasks = tasks.append(task, ignore_index=True)
    task_df = pd.DataFrame([task])
    task_df.to_sql('Tasks', con=engine, if_exists='append', index=False)
    return task

def start_task(task_id):
    task = tasks[tasks['task_id'] == task_id].iloc[0]
    task['is_completed'] = 1
    task['start_time'] = pd.Timestamp.now()
    tasks.update(task)
    tasks.to_sql('Tasks', con=engine, if_exists='append', index=False)
    return task

def end_task(task_id):
    task = tasks[tasks['task_id'] == task_id].iloc[0]
    task['is_completed'] = 1
    task['end_time'] = pd.Timestamp.now()
    tasks.update(task)
    tasks.to_sql('Tasks', con=engine, if_exists='append', index=False)
    return task

# Example usage
# Get the first flight arrival

# Sort flight arrivals by aibt
flight_arrivals = flight_arrivals.sort_values(by='aibt')

for flight_arrival in flight_arrivals.itertuples():
    task_1 = create_first_task_for_flight_arrival(flight_arrivals.loc[0,:])
    print(f"Task created for flight arrival {flight_arrival.arrival_id} with driver {task_1['driver_id']}")
    


start_task(task_1['task_id'])
end_task(task_1['task_id'])




