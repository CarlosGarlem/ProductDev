from typing import List
from fastapi import FastAPI
from functools import reduce
from enum import Enum

app = FastAPI() #uvicorn main:app --reload        (this will start the server, app has to be the same variables that receives the FastAPI() class)

class Operations(str, Enum):
    addition = 'addition'
    substraction = 'substraction'
    multiplication = 'multiplication'
    division = 'division'


@app.post('/addition')
def sum_values(array: List[int] = None):
    result = reduce(lambda x, y: x + y, array)
    return {'sum': result}


@app.post('/substraction')
def substract_values(array: List[int] = None):
    result = reduce(lambda x, y: x - y, array)
    return {'substraction': result}


@app.post('/multiplication')
def multiply_values(array: List[int] = None):
    result = reduce(lambda x, y: x * y, array)
    return {'multiplication': result}


@app.post('/division')
def divide_values(array: List[int] = None):
    result = reduce(lambda x, y: x / y, array)
    return {'division': result}



@app.post('/operate/{operation}')
def operate_values(operation: Operations, array: List[int] = None):
    if operation == Operations.addition:
        result = reduce(lambda x, y: x + y, array)
    elif operation == Operations.substraction:
        result = reduce(lambda x, y: x - y, array)
    elif operation == Operations.multiplication:
        result = reduce(lambda x, y: x * y, array)
    elif operation == Operations.division:
        result = reduce(lambda x, y: x / y, array)

    return {'result': result}

