user_queries=[]
disease_queries=[]
vaccine_queries=[]
healthcentre_queries=[]
country_queries=[]
user_queries.append("insert into users values("+id+','+ full_name+','+ Gender+','+ DOB+','+ emailID+','+state+','+Address+','+Contact+','+GuardianName+','+AadharNumber+')')
#Display citizens of Bihar vaccinated against the disease SHINGLES.
disease_queries.append("Select U.id,U.full_name from users U, VaccinationRecords V,Disease D, DiseaseVaccineRelation R where V.UserID=U.id and V.VaccineID=R.VaccineID and R.ICDCode=D.ICD10 and  U.state='Bihar' and D.Name='SHINGLES'")

"""
    NOTE: SARGAM subqueries nest them like this below, performance is way higher and less records are accessed
"""
disease_queries.append("Select id, full_name from users where state='Bihar' and id = (Select UserId from VaccinationRecords where VaccineID=(Select R.VaccineID from Disease D, DiseaseVaccineRelation R where D.name = 'Shingles' and D.ICD10=R.ICDCode));")
z

user_queries.append("insert into users values("+id+','+ full_name+','+ Gender+','+ DOB+','+ emailID+','+state+','+Address+','+Contact+','+GuardianName+','+Aadhar Number+')')

#Display citizens of Bihar vaccinated against the disease SHINGLES.
disease_queries.append("Select id, full_name from users where state='Bihar' and id = (Select UserID from VaccinationRecords where VaccineID=(Select R.VaccineID from Disease D, DiseaseVaccineRelation R where D.name = 'Shingles' and D.ICD10=R.ICDCode));")

#lists the unfulfilled vaccine requirements for a user according to a particular country
user_queries.append("Select V.name from Vaccinations V where V.VaccineID in (Select VaccinationID from CountryImmunizationRecords where CountryCode='IN') and V.VaccineID in(select VaccineID from DiseaseVaccineRelation where ICDCode in (select ICD10 from Disease)) and V.VaccineID not in ( select A.VaccineID from VaccinationRecords A where A.UserID=4)")
#list vaccination record for a particular user
user_queries.append("select * from VaccinationRecords where UserID=73")
#create new user
user_queries.append("insert into users values("+id+','+ full_name+','+ Gender+','+ DOB+','+ emailID+','+state+','+Address+','+Contact+','+GuardianName+','+Aadhar Number+')')

#Display citizens of Bihar vaccinated against the disease SHINGLES.
disease_queries.append("Select id, full_name from users where state='Bihar' and id = (Select UserID from VaccinationRecords where VaccineID=(Select R.VaccineID from Disease D, DiseaseVaccineRelation R where D.name = 'Shingles' and D.ICD10=R.ICDCode));")

#Print Users and their vaccination dates done in Public Health Centres-'Health Centre1','Browsebug','Zoomcast','Blogpad','Yabox'
healthcentre_queries.append("Select U.id,U.full_name,V.VaccineDate,P.name from users U,VaccinationRecords V, PublicHealthCentre P where U.id=V.UserID and P.id=V.PublicHealthCentreID and P.name in ('Health Centre1','Browsebug','Zoomcast','Blogpad','Yabox')")
#Check the availability of vaccine for Pneumococcal disease in health centre with name 
healthcentre_queries.append("select A.count from Availability A where A.VaccineID in (select VaccineID from DiseaseVaccineRelation where ICDCode = (select ICD10 from Disease where Name='Pneumococcal ')) and A.healthCentreID = (select id from PublicHealthCentre where name='Zoonder')")
#public Health Centre Records of a given date
healthcentre_queries.append("select * from VaccinationRecords where PublicHealthCentreID =( select id from PublicHealthCentre where name='Blogpad') and VaccineDate ='2020-03-03'")
#vaccine camps organised by a health centre between given dates.
healthcentre_queries.append("select * from VaccineCamps where HealthCentreID= 45 and StartDate >= '2020-03-01' and StartDate <='2020-03-31'")

#Print country vaccine requirements by country code
country_queries.append("Select V.name from Vaccinations V where V.VaccineID=(Select VaccinationID from CountryImmunizationRecords,DiseaseVaccineRelation where VaccinationID= VaccineID and CountryCode='KH' and ICDCode in (select ICD10 from Disease))")
# Print country vaccine requiremnets by country name
country_queries.append("Select V.name from Vaccinations V where V.VaccineID=(Select VaccinationID from CountryImmunizationRecords,DiseaseVaccineRelation where VaccinationID= VaccineID and CountryName='India' and ICDCode in (select ICD10 from Disease))")

#print user details who recieved the vaccine with code-'8462-192'
vaccine_queries.append("select U.id, U.full_name, U.emailID, D.Name from users U, Disease D where D.ICD10 in (select ICDCode from DiseaseVaccineRelation where VaccineID in (select VaccineID from VaccinationRecords where VaccineCode='33261-975')) and U.id in(select UserID from VaccinationRecords where VaccineCode = '33261-975' )")

"""
    INDEXES ADDED - 2
    QUERIES TO ADD
    --------------
    1. Public Health Centre records by date / Similarly Vaccine Camps info by date -DONE
    2. 
"""
