from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World'

@app.route('/login')
def login():
    return 'Login'

@app.route('/signup')
def signup():
    return 'Signup'

@app.route('/addRecord')
def addRecord():
    return 'record'

@app.route('/deleteRecord')
def deleteRecord():
    return 'delete record'

@app.route('/viewRecords')
def viewRecords():
    return 'view records'
