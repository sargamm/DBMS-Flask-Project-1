# IMPORTS
from flask import Flask, url_for
from flask import request
from flask import render_template
from config import *
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash, generate_password_hash

#INITIALIZATIONS
app = Flask(__name__)

app.config['MYSQL_HOST'] = MYSQL_DATABASE_HOST
app.config['MYSQL_USER'] = MYSQL_DATABASE_USER
app.config['MYSQL_PASSWORD'] = MYSQL_DATABASE_PASSWORD
app.config['MYSQL_DB'] = MYSQL_DATABASE_DB

mysql = MySQL(app)

# APP ROUTES
@app.route('/', methods=['GET'])
def hello_world():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if (request.method  == 'POST'):
        return 'Login Attempt'
    else:
        return render_template('index.html')

@app.route('/signup')
def signup():
    return render_template('signup.html')

@app.route('/addRecord')
def addRecord():
    return 'record'

@app.route('/deleteRecord')
def deleteRecord():
    return 'delete record'

@app.route('/viewRecords')
def viewRecords():
    return 'view records'
