# IMPORTS
from flask import Flask, url_for
from flask import request
from flask import render_template, redirect
from flask import session, jsonify
from datetime import date, datetime
from config import *
from flask_mysqldb import MySQL
from werkzeug.security import check_password_hash, generate_password_hash
import mysql.connector


#INITIALIZATIONS
app = Flask(__name__)
app.config['SECRET_KEY'] = SECRET_KEY
app.config['MYSQL_HOST'] = MYSQL_DATABASE_HOST
app.config['MYSQL_USER'] = MYSQL_DATABASE_USER
app.config['MYSQL_PASSWORD'] = MYSQL_DATABASE_PASSWORD
app.config['MYSQL_DB'] = MYSQL_DATABASE_DB
app.config['MYSQL_PORT'] = 3306


#mydb = mysql.connector.connect(
#  host="localhost",
#  user="binaryblood",
#  password='vg261999',
#)

#mydb.close()

#print(mydb)

mysql = MySQL(app)

# APP ROUTES
@app.route('/', methods=['GET'])
def hello_world():
    return render_template('home.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if (request.method  == 'POST'):
        query = "SELECT name, userID, password, roleID from AuthUsers WHERE emailID LIKE (%s)"
        email = request.form.get('email')
        password = request.form.get('password')
        if (email == None or password == None):
            return 'error'
        cur = mysql.connection.cursor()
        cur.execute(str(query), [email])
        x = cur.fetchone()
        if (x == None):
            cur.close()
            return render_template('index.html', errors=["Email does not exist"])
        if (password != x[2]):
            cur.close()
            return render_template('index.html', errors=["Email and Password do not match"])
        #print(result)
        #mysql.connection.commit()
        else:
            session['loggedIn'] = True
            session['userId'] = x[1]
            session['userName'] = x[0].upper()
            session['roleID'] = x[3]
            print(x[3])
            cur.close()
            return render_template('home.html')
    else:
        return render_template('index.html')

@app.route('/signup',methods=['GET','POST'])
def signup():
    if(request.method == 'POST'):
        role = int(request.form.get('role'))
        roles_dictionary={1:"HealthCentreRegister", 2:"MedPractitionerRegister", 3: "GovtOfficialRegister"}
        return redirect(url_for(roles_dictionary[role]))     
    else:
        return render_template('RoleSelect.html')

@app.route('/HealthCentreSignup', methods=['GET', 'POST'])
def HealthCentreRegister():
    if request.method == 'POST':
        if (session.get("loggedIn") != None):
            return render_template('RegisterHealthCentre.html')
        else:
            errors = []
            name = request.form.get('name')
            contact = request.form.get('contact')
            email = request.form.get('email')
            password = request.form.get('password')
            c_password = request.form.get('c_password')
            pincode = request.form.get('pincode')
            address=request.form.get('address')
            NoOfHealthCamps=request.form.get('NoOfHealthCamps')
            OperationalSince=request.form.get('OperationalSince')
            State=request.form.get('state')
            city=request.form.get('City')
            if (password != c_password):
                errors.append("Passwords don't match")
            if (len(pincode) < 6):
                errors.append("Pincode too short")
            if (len(errors) == 0):
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO AuthUsers(password, emailID, contact, roleID, name) VALUES (%s, %s, %s, %s, %s)", [password, email, contact, 1, name])
                AuthuserId = cur.lastrowid
                cur.execute("INSERT INTO PublicHealthCentre(id,name,pincode,address,NumberOfHealthCamps,OperationalSince,city,state,Contact) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",[51,name,pincode,address,NoOfHealthCamps,OperationalSince,city,State,contact])
                healthCentreID=cur.lastrowid
                #cur.execute("INSERT INTO AuthUserHealthCentreRelation(AuthUserID,HealthCentreID) VALUES (%s,%s)",[AuthuserId,healthCentreID])
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('login'))
            else:
                return render_template('RegisterHealthCentre.html', errors=errors)
            
    else:
        return render_template('RegisterHealthCentre.html')

@app.route('/MedicalPractitionerSignup', methods=['GET', 'POST'])
def MedPractitionerRegister():
    if request.method == 'POST':
        if (session.get("loggedIn") != None):
            return render_template('RegisterMedPractitioner.html')
        else:
            errors = []
            name = request.form.get('name')
            contact = request.form.get('contact')
            email = request.form.get('email')
            password = request.form.get('password')
            c_password = request.form.get('c_password')
            PracticingSince=request.form.get('PracticingSince')
            licenseNo=request.form.get('license')
            HealthCentreID=request.form.get('healthCentreID')
            if (password != c_password):
                errors.append("Passwords don't match")
            if (len(errors) == 0):
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO AuthUsers(password, emailID, contact, roleID, name) VALUES (%s, %s, %s, %s, %s)", [password, email, contact, 2, name])
                AuthuserId = cur.lastrowid
                cur.execute("INSERT INTO RegisteredPractitioners(userID, LicenseNumber,name,practicingSince, healthCentreID) Values (%s,%s,%s,%s,%s)", [AuthuserId,licenseNo,name,PracticingSince,HealthCentreID])
                userID=cur.lastrowid
                #cur.execute("INSERT INTO AuthUserHealthCentreRelation(AuthUserId,HealthCentreID) VALUES (%s,%s)",[AuthuserId,userID])
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('login'))
            else:
                return render_template('RegisterMedPractitioner.html', errors=errors)
            
    else:
        return render_template('RegisterMedPractitioner.html')

@app.route('/GovtOfficialSignup', methods=['GET', 'POST'])
def GovtOfficialRegister():
    if (request.method  == 'POST'):
        if (session.get("loggedIn") != None):
            return render_template('signup.html')
        else:
            errors = []
            name = request.form.get('name')
            email = request.form.get('email')
            dateString = request.form.get('dob')
            dob = datetime.strptime(dateString, '%Y-%m-%d').date()
            print(dob)
            password = request.form.get('password')
            c_password = request.form.get('c_password')
            gender = request.form.get('gender')
            pincode = request.form.get('pincode')
            contact = request.form.get('contact')
            if (password != c_password):
                errors.append("Passwords don't match")
            if (len(pincode) < 6):
                errors.append("Pincode too short")
            if (len(errors) == 0):
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO AuthUsers(password, emailID, roleID, name) VALUES(%s, %s, %s, %s)", [password, email, 1, name])
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('login'))
            else:
                return render_template('signup.html', errors=errors)
            
    else:
        return render_template('signup.html')

@app.route('/logout')
def logout():
    session.pop('loggedIn', None)
    session.pop('userId', None)
    session.pop('userName', None)
    return redirect('/login')

@app.route('/addRecord', methods=['POST','GET'])
def addRecord():
    if( request.method == 'POST'):
        vaccineID = request.form.get('VaccineID')
        userID = request.form.get('userID')
        dateString = request.form.get('vaccineDate')
        vaccineDate = datetime.strptime(dateString, '%Y-%m-%d').date()
        dosage= request.form.get('dosage')
        CampId= request.form.get('campId')
        vaccineCode=request.form.get('v_code')
        licenseNo=request.form.get('license')
        HealthCentreID=request.form.get('HealthCentreID') 
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO VaccinationRecords(VaccineID,UserID,VaccineDate,PublicHealthCentreID,DosageNo,CampID,DoctorLicenseNo,VaccineCode) Values (%s,%s,%s,%s,%s,%s,%s,%s)",[vaccineID,userID,vaccineDate,HealthCentreID,dosage,CampId,licenseNo,vaccineCode])
        mysql.connection.commit()
        cur.close()
    else:
        return render_template('insertVaccineRecord.html')

@app.route('/generalQuery', methods=['POST'])
def generalQuery():
    try:
        contact = request.form.get('contact')
        aadhar = request.form.get('aadhar')
        query = 'SELECT V.VaccineDate, S.name, V.DosageNo FROM VaccinationRecords as V LEFT JOIN Vaccinations as S ON V.VaccineID=S.VaccineID where V.UserID=(Select id from users where Contact="%s" and AadharNumber="%s")'  
        cur = mysql.connection.cursor()
        cur.execute(str(query), [contact, aadhar])
        result = cur.fetchall()
        num_fields = len(cur.description)
        header_list = [i[0] for i in cur.description]
        if (len(result) == 0):
            return jsonify({'data': render_template('result.html', errors="No record for the provided input")}) 
        return jsonify({'data': render_template('result.html', object_list=result, header_list=header_list)})
    except Exception as e:
        return jsonify({'data': render_template('result.html', errors="Error fetching values for input provided!")})

@app.route('/countryRequirements', methods=["GET", "POST"])
def countryWiseRequirements():
    if (request.method == "POST"):
        country=request.form.get('country')
        country = country.lower()
        #country.capitalize()
        cur = mysql.connection.cursor()
        #cur.execute("Select V.name from Vaccinations V where V.VaccineID=(Select VaccinationID from CountryImmunizationRecords,DiseaseVaccineRelation where VaccinationID= VaccineID and CountryName=%s and ICDCode in (select ICD10 from Disease))",[country])
        param = "%" + str(country) + "%"
        query = "SELECT * FROM CountryWiseRequirements as C where LOWER(C.CountryName) LIKE %s"
        cur.execute(str(query), [param])
        records = cur.fetchall()
        num_fields = len(cur.description)
        header_list = [i[0] for i in cur.description]
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list)})    
    else:
        return redirect("/")

@app.route('/deleteRecord')
def deleteRecord():
    return 'delete record'

@app.route('/viewRecords')
def viewRecords():
    return 'view records'

@app.route('/covidTimeMap')
def covidTimeMap():
    target = request.args.get('id')
    if target == '1':
        return render_template('nationalTimeLine.html')
    elif target == '2':
        return render_template('nationalTimeLine_recovered.html')
    elif target == '3':
        return render_template('nationalTimeLine_deaths.html')
    else:
        return render_template('nationalTimeLine.html')
    


'''
    FOR THE IN QUERY!
    format_strings = ','.join(['%s'] * len(list_of_ids))
    cursor.execute("DELETE FROM foo.bar WHERE baz IN (%s)" % format_strings,
                tuple(list_of_ids))

                CREATE DEFINER = CURRENT_USER TRIGGER `vaccination_table`.`Availability_BEFORE_INSERT` BEFORE INSERT ON `Availability` FOR EACH ROW
BEGIN
	declare msg varchar(128);
	if exists (SELECT * from Availability
    where healthCentreID=new.healthCentreID and VaccineID=new.VaccineID) 
    then
		set msg = concat('VacciCureError: Trying to insert into existing entry');
		signal sqlstate '45000' set message_text = msg;
	else
		if (new.Count < 0) then
        set msg = concat('VacciCureError: Negative entry not allowed');
		signal sqlstate '45000' set message_text = msg;
        end if;
    end if;
END

'''