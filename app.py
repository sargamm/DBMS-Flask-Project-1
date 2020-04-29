# IMPORTS
from flask import Flask, url_for, flash
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
            if (str(x[3]) == '1'):
                try:
                    cur.execute('SELECT HealthID from HealthCentreAuthMap where AuthID=%s', [x[1]])
                    healthID = cur.fetchone()
                    session['specificID'] = healthID[0]
                finally:
                    print(session['specificID'])
            elif (str(x[3]) == '2'):
                try:
                    cur.execute('SELECT DoctorID from DoctorAuthMap where AuthID=%s', [x[1]])
                    doctorID = cur.fetchone()
                    session['specificID'] = doctorID[0]
                    #cur.close()
                finally:
                    #cur.close()
                    print("Didn't find ID!")
            #print(x[3])
            cur.close()
            return render_template('home.html')
    else:
        cur = mysql.connection.cursor()
        if (session.get("specificID") != None):
            if (str(session.get('roleID')) == '1'):
                formData = []
                cur.execute('SELECT * from PublicHealthCentre where id=%s', [session.get("specificID")])
                formData = cur.fetchone()
                print(formData)
                return render_template('index.html', formData=formData) 
            elif (str(session.get('roleID')) == '2'):
                formData = []
                cur.execute('SELECT * from RegisteredPractitioners where LicenseNumber=%s', [session.get("specificID")])
                formData = cur.fetchone()
                print(formData)
                return render_template('index.html', formData=formData)
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
            print(request.form)
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
                try:
                    cur.execute("INSERT INTO AuthUsers(password, emailID, contact, roleID, name) VALUES (%s, %s, %s, %s, %s)", [password, email, contact, 1, name])
                    AuthuserId = cur.lastrowid
                    cur.execute("INSERT INTO PublicHealthCentre(id,name,pincode,address,NumberOfHealthCamps,OperationalSince,city,state,Contact) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",[AuthuserId,name,pincode,address,NoOfHealthCamps,OperationalSince,city,State,contact])
                    healthCentreID=cur.lastrowid
                    cur.execute("INSERT INTO HealthCentreAuthMap(AuthID,HealthID) VALUES (%s,%s)",[AuthuserId,healthCentreID])
                    mysql.connection.commit()
                    cur.close()
                    return redirect(url_for('login'))
                except Exception as e:
                    mysql.connection.rollback()
                    cur.close()
                    return redirect('/login')
            else:
                return redirect('/login')
            
    else:
        return render_template('RegisterHealthCentre.html')

@app.route('/HealthCentreUpdate', methods=["POST"])
def healthCentreUpdate():
    if (session.get("loggedIn") == None):
        return redirect('/login')
    else:
        print("HERE!")
        errors = []
        name = request.form.get('name')
        contact = request.form.get('contact')
        pincode = request.form.get('pincode')
        address=request.form.get('address')
        NoOfHealthCamps=request.form.get('NoOfHealthCamps')
        OperationalSince=request.form.get('OperationalSince')
        State=request.form.get('state')
        city=request.form.get('City')
        print(name)
        if (len(pincode) < 6):
            errors.append("Pincode too short")
        if (len(errors) == 0):
            cur = mysql.connection.cursor()
            try:
                cur.execute("UPDATE PublicHealthCentre SET name=%s,pincode=%s,address=%s,NumberOfHealthCamps=%s,OperationalSince=%s,city=%s,state=%s,Contact=%s where id=%s",[name,pincode,address,NoOfHealthCamps,OperationalSince,city,State,contact, session.get("specificID")])
                print("SUCCESS")
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('login'))
            except Exception as e:
                mysql.connection.rollback()
                cur.close()
                flash("VacciCure: Error occured")
                return redirect(url_for('login'))
        else:
            flash("VacciCure: Error occured")
            return redirect(url_for('login'))


@app.route('/MedicalPractitionerSignup', methods=['GET', 'POST'])
def MedPractitionerRegister():
    if request.method == 'POST':
        if (session.get("loggedIn") != None):
            return redirect("/login")
        else:
            print("HERE!")
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
                try:
                    print("HERE!!!!")
                    cur.execute("INSERT INTO AuthUsers(password, emailID, contact, roleID, name) VALUES (%s, %s, %s, %s, %s)", [password, email, contact, 2, name])
                    AuthuserId = cur.lastrowid
                    cur.execute("INSERT INTO RegisteredPractitioners(userID, LicenseNumber,name,practicingSince, healthCentreID) Values (%s,%s,%s,%s,%s)", [AuthuserId,licenseNo,name,PracticingSince,HealthCentreID])
                    userID=licenseNo
                    print("User ID:", userID)
                    cur.execute("INSERT INTO DoctorAuthMap(AuthID,DoctorID) VALUES (%s,%s)",[AuthuserId,userID])        
                    mysql.connection.commit()
                    cur.close()
                    print("DONE!")
                    return redirect(url_for('login'))
                except Exception as e:
                    mysql.connection.rollback()
                    cur.close()
                    return render_template('RegisterMedPractitioner.html', errors=["VacciCure Error: Check your input again!"])
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
                cur.execute("INSERT INTO AuthUsers(password, emailID, roleID, name) VALUES(%s, %s, %s, %s)", [password, email, 3, name])
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
    session.pop('specificID', None)
    session.pop('roleID', None)
    return redirect('/login')

@app.route('/addRecord', methods=['POST','GET'])
def addRecord():
    if( request.method == 'POST'):
        try:
            vaccineID = request.form.get('VaccineID')
            aadhar=request.form.get('Aadhar')
            dateString = request.form.get('vaccineDate')
            vaccineDate = datetime.strptime(dateString, '%Y-%m-%d').date()
            dosage= request.form.get('dosage')
            CampId= request.form.get('campId')
            vaccineCode=request.form.get('v_code')
            licenseNo=request.form.get('license')
            HealthCentreID=request.form.get('HealthCentreID') 
            cur = mysql.connection.cursor()
            cur.execute("select id from users where AadharNumber like %s",[aadhar])
            x=cur.fetchone()
            userID=x[0]
            cur.execute("INSERT INTO VaccinationRecords(VaccineID,UserID,VaccineDate,PublicHealthCentreID,DosageNo,CampID,DoctorLicenseNo,VaccineCode) Values (%s,%s,%s,%s,%s,%s,%s,%s)",[vaccineID,userID,vaccineDate,HealthCentreID,dosage,CampId,licenseNo,vaccineCode])
            mysql.connection.commit()
        except Exception as e:
            mysql.connection.rollback()
        finally:
            cur.close()
        return render_template('insertVaccineRecord.html')
    else:
        return render_template('insertVaccineRecord.html')

@app.route('/generalQuery', methods=['POST'])
def generalQuery():
    try:
        contact = request.form.get('contact')
        name=request.form.get('name')
        aadhar = request.form.get('aadhar')
        query = 'SELECT V.VaccineDate, S.name, V.DosageNo FROM VaccinationRecords as V LEFT JOIN Vaccinations as S ON V.VaccineID=S.VaccineID where V.UserID=(Select id from users where (Contact="%s" and name="%s") or AadharNumber="%s")'  
        cur = mysql.connection.cursor()
        cur.execute(str(query), [contact,name,aadhar])
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
        return redirect(url_for('hello_world'))

@app.route('/Availability', methods=['GET','POST'])
def checkAvailability():
    if (request.method == 'POST'):
        vaccineID=request.form.get('vaccineID')
        heathCentreID=request.form.get('HealthCentreID')
        cur=mysql.connection.cursor()
        cur.execute("select count,VaccineID from Availability where VaccineID=%s and HealthCentreID=%s", [vaccineID,heathCentreID])
        records=cur.fetchall()
        header_list=['Stock','vaccine ID']
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list)})    
    else:
        return render_template('checkAvailability.html')

@app.route('/UpdateAvailability', methods=['GET','POST'])
def UpdateAvailability():
    if (request.method == 'POST'):
        vaccineID=request.form.get('vaccineID')
        heathCentreID=request.form.get('HealthCentreID')
        stock=request.form.get('Stock')
        cur=mysql.connection.cursor()
        cur.execute("select Count from Availability where VaccineID=%s and HealthCentreID=%s", [vaccineID,heathCentreID])
        records=cur.fetchone()
        if records == None:
            cur.execute("insert into Availability(Count,VaccineID,HealthCentreID) values (%s,%s,%s)",[stock,vaccineID,heathCentreID])
        else:
            stock=int(stock)+int(records[0])
            print(stock)
            cur.execute("Update Availability set Count=%s where VaccineID=%s and HealthCentreID=%s",[stock,vaccineID,heathCentreID])
        mysql.connection.commit()
        cur.close()
        return redirect("/")
    else:
        return render_template('addStock.html')
        
@app.route('/AvailabilityforUser', methods=['GET','POST'])
def checkAvailabilityForUser():
    if (request.method == 'POST'):
        vaccineID=request.form.get('vaccineID')
        cur=mysql.connection.cursor()
        cur.execute("select * from PublicHealthCentre where id in(select healthCentreID from Availability where Count>0 and VaccineID=%s)", [vaccineID])
        records=cur.fetchall()
        header_list=[i[0] for i in cur.description]
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list)})    
    else:
        return render_template('userAvailability.html')

@app.route('/RegisterUser', methods=['GET','POST'])
def RegisterUser():
    if(request.method=='POST'):
        errors=[]
        name = request.form.get('name')
        email = request.form.get('email')
        dateString = request.form.get('dob')
        dob = datetime.strptime(dateString, '%Y-%m-%d').date()
        gender = request.form.get('gender')
        pincode = request.form.get('pincode')
        contact = request.form.get('contact')
        address=request.form.get('address')
        State=request.form.get('state')
        g_name=request.form.get('g_name')
        aadhar = request.form.get('aadhar')
        if (len(pincode) < 6):
            errors.append("Pincode too short")
        if(len(errors)==0):
            cur=mysql.connection.cursor()
            cur.execute( "insert into users(full_name,Gender,DOB,emailID,pincode,state,Address,Contact,GuardianName,AadharNumber) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", [name,gender,dob,email,pincode,State,address,contact,g_name,aadhar])
            mysql.connection.commit()
            cur.close()
            return redirect('/')
        else:
            return render_template('RegisterUser.html',errors=errors)
    else:
        return render_template('RegisterUser.html')

def vaccineCountByState():
    cur=mysql.connection.cursor()
    cur.callproc('vaccineCountByState', args=())
    result = cur.fetchall()
    #print(result)
    cur.close()
    output = []
    for r in result:
        temp = {}
        temp['state'] = r[0]
        temp['count'] = r[1]
        output.append(temp)
    return output

@app.route('/vaccineIDInfo', methods=["POST", "GET"])
def vaccineIDInfoGUI():
    if (request.method == 'POST'):
        vaccineID = request.form['vaccineid']
        cur=mysql.connection.cursor()
        args = (int(vaccineID), )
        cur.callproc('getInfoOnVaccineID', args)
        records = cur.fetchall()
        #print(result)
        #cur.close()
        header_list=[i[0] for i in cur.description]
        cur.close()
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list, title="Vaccine Info for Specific ID")})
    else:
        return render_template('vaccineCount.html', title="Vaccine Info for Specific ID")

@app.route('/vaccineCountByState', methods=["POST", "GET"])
def vaccineCountByStateGUI():
    if (request.method == 'POST'):
        cur=mysql.connection.cursor()
        cur.callproc('vaccineCountByState', args=())
        records = cur.fetchall()
        header_list=[i[0] for i in cur.description]
        cur.close()
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list, title="Vaccine County By State", option=1)})
    else:
        return render_template('vaccineCount.html', title="Vaccine County By State", option=1)

@app.route('/api/vaccineCountByState')
def vaccineCountByStateAPI():
    return jsonify({'data': vaccineCountByState()})

@app.route('/moreInfo',methods=['GET','POST'])
def moreInfo():
    if(request.method=='POST'):
        cur=mysql.connection.cursor()
        cur.execute("select * from DiseaseVaccineMap")
        records=cur.fetchall()
        header_list=[i[0] for i in cur.description]
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list)})      
    else:
        return render_template('moreInfo.html')

@app.route('/HealthCentreVaccinationRecords',methods=['GET','POST'])
def HealthCentreRecords():
    if(request.method=='POST'):
        cur=mysql.connection.cursor()
        ID=session['specificID']
        cur.execute("select * from VaccinationRecords where HealthCentreID=%s",)
        records=cur.fetchall()
        header_list=[i[0] for i in cur.description]
        return jsonify({'data': render_template('result.html', object_list=records, header_list=header_list)})      
    else:
        return render_template('HealthCentreRecord.html')


@app.route('/deleteRecord')
def deleteRecord():
    if (session.get("loggedIn") != None):
        cur = mysql.connection.cursor()
        print(session.get("userId")) 
        query = "DELETE FROM AuthUsers WHERE userID=%s"
        cur.execute(str(query), [session.get("userId")])
        mysql.connection.commit()
        cur.close()
        session.pop('loggedIn', None)
        session.pop('userId', None)
        session.pop('userName', None)
        session.pop('specificID', None)
        session.pop('roleID', None)
    return redirect("/login")

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
    
@app.route('/changePassword', methods=['POST'])
def changePassword():
    if (request.method == 'POST'):
        password = request.form['password']
        c_password = request.form['c_password']
        if (len(password) < 6):
            return render_template('index.html', errors=["Password too weak"])
        if (password == c_password):
            cur = mysql.connection.cursor()
            try:
                query = "UPDATE AuthUsers set password=%s WHERE userID=%s"
                cur.execute(str(query), [password, session.get("userId")])
                mysql.connection.commit()
                cur.close()
                return render_template('index.html', errors=["Password changed successfully!"])
            except:
                mysql.connection.rollback()
                cur.close()
                return render_template('index.html', errors=["Some error has occured!"])
        else:
            return render_template('index.html', errors=["Passwords don't match"])
    else:
        return redirect('/login')

@app.route('/changeNameAndContact')
def changeNameAndContact():
    if (request.method == 'POST'):
        name = request.form['name']
        contact = request.form['contact']
        if (len(contact) < 10):
            return render_template('index.html', errors=["Contact too short"])
        cur = mysql.connection.cursor()
        try:
            query = "UPDATE AuthUsers set name=%s, contact=%s WHERE userID=%s"
            cur.execute(str(query), [name, contact, session.get("userId")])
            mysql.connection.commit()
            cur.close()
            return render_template('index.html', errors=["Name and contact updated!"])
        except:
            mysql.connection.rollback()
            cur.close()
            return render_template('index.html', errors=["Some error has occured!"])
    else:
        return redirect('/login')

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

SELECT P.state, P.name, S.PublicHealthCentreID, S.Cnt FROM PublicHealthCentre as P, (  
SELECT PublicHealthCentreID, COUNT(*) as Cnt, VaccineID 
FROM VaccinationRecords
WHERE VaccineID=90644
GROUP BY PublicHealthCentreID) AS S
where P.id=S.PublicHealthCentreID 
order BY S.CNT desc;


'''