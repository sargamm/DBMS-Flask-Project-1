user_queries=[]
disease_queries=[]
vaccine_queries=[]
healthcentre_queries=[]
country_queries=[]

#lists the unfulfilled vaccine requirements for a user according to a particular country
user_queries.append("Select V.name, D.Name from Vaccinations V, Disease D,DiseaseVaccineRelation R, CountryImmunizationRecords C where C.VaccinationID=V.VaccineID and V.VaccineID=R.VaccineID and D.ICD10=R.ICDCode and C.CountryCode='IN' and V.VaccineID not in ( select A.VaccineID from VaccinationRecords A where A.UserID=4) ")
#list vaccination record for a particular user
user_queries.append("select * from VaccinationRecords where UserID=73")
#create new user
user_queries.append("insert into users values("+id+','+ full_name+','+ Gender+','+ DOB+','+ emailID+','+state+','+Address+','+Contact+','+GuardianName+','+Aadhar Number+')')
#Display citizens of Bihar vaccinated against the disease SHINGLES.
disease_queries.append("Select U.id,U.full_name from users U, VaccinationRecords V,Disease D, DiseaseVaccineRelation R where V.UserID=U.id and V.VaccineID=R.VaccineID and R.ICDCode=D.ICD10 and  U.state='Bihar' and D.Name='SHINGLES'")

"""
    NOTE: SARGAM subqueries nest them like this below, performance is way higher and less records are accessed
"""
disease_queries.append("Select id, full_name from users where state='Bihar' and id = (Select UserId from VaccinationRecords where VaccineID=(Select R.VaccineID from Disease D, DiseaseVaccineRelation R where D.name = 'Shingles' and D.ICD10=R.ICDCode));")

#Print Users and their vaccination dates done in Public Health Centres-'Health Centre1','Browsebug','Zoomcast','Blogpad','Yabox'
healthcentre_queries.append("Select U.id,U.full_name,V.VaccineDate,P.name from users U,VaccinationRecords V, PublicHealthCentre P where U.id=V.UserID and P.id=V.PublicHealthCentreID and P.name in ('Health Centre1','Browsebug','Zoomcast','Blogpad','Yabox')")
#Check the availability of vaccine for Pneumococcal disease in health centre with name 
healthcentre_queries.append("Select A.count from Availability A, DiseaseVaccineRelation R,Disease D, PublicHealthCentre H where H.name='Zoonder' and D.name='Pneumococcal 'and D.ICD10=R.ICDCode and R.VaccineID=A.VaccineID")

#Print country vaccine requirements by country code
country_queries.append("Select V.name, D.Name from Vaccinations V, Disease D,DiseaseVaccineRelation R, CountryImmunizationRecords C where C.VaccinationID=V.VaccineID and V.VaccineID=R.VaccineID and D.ICD10=R.ICDCode and C.CountryCode='KH'")
# Print country vaccine requiremnets by country name
country_queries.append("Select V.name, D.Name from Vaccinations V, Disease D,DiseaseVaccineRelation R, CountryImmunizationRecords C where C.VaccinationID=V.VaccineID and V.VaccineID=R.VaccineID and D.ICD10=R.ICDCode and C.CountryName='India'")

#print user details who recieved the vaccine with code-'8462-192'
vaccine_queries.append("select U.id, U.full_name, U.emailID, V.VaccineCode, D.Name from users U,VaccinationRecords V, DiseaseVaccineRelation R, Disease D where V.VaccineCode='8462-192' and V.VaccineID=R.VaccineID and R.ICDCode=D.ICD10")

"""
    INDEXES ADDED - 2
    QUERIES TO ADD
    --------------
    1. Public Health Centre records by date / Similarly Vaccine Camps info by date
    2. 
"""