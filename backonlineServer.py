################################################################################
# Server file for servey
# Created 14/10/2018; Last modified 11/12/2018

################################################################################
#Imports
import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3
import datetime

################################################################################
# Initialise flask and get database name
app = Flask(__name__)
DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
QuestGroup = 0

################################################################################
# Goes to initial select login option page
@app.route("/", methods=['GET'])
def getFirst():
    if request.method== 'GET':
        return render_template('First.html')

################################################################################
# Render admin login page
@app.route("/Admin", methods=['GET'])
def getAdmin():
    if request.method== 'GET':
        return render_template('Admin.html')

################################################################################
# Process admin login attempt
@app.route("/Process", methods=['GET', 'POST'])
def AllAdmin():
    # Get data from form
    if request.method== 'GET':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        print("Validating")
        return render_template('Admin.html')

    # Get data from form
    if request.method == 'POST':
        Email = request.form.get('email', default="Error")
        Password = request.form.get('psw', default="Error")
        print(Email, Password)

        # Get data from db
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT PatientID, FirstName, SurName, Email, Age, Gender FROM Patient;")
        dispat = cur.fetchall()
        print(dispat)

        # Get data from db
        cur.execute("SELECT Email, Password FROM Staff WHERE Email=? AND Password=?",[Email,Password])
        Login_admin= cur.fetchall()
        conn.close()
        print(Login_admin)

        # If valid login render select_patient
        if Login_admin != []:
            if Email == Login_admin[0][0] and Password == Login_admin[0][1]:
                return render_template('Select_patient.html', dispat= dispat)
        return render_template('Admin.html')

################################################################################
# Retrives the patient data from db for displaing on the page
@app.route("/Select/<patient_id>", methods=['GET', 'POST'])
def getSelect(patient_id):

    try:
        # Get data from db
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT PatientID, FirstName, SurName, Email, Age, Gender FROM Patient WHERE PatientID=? ;", [patient_id])
        data = cur.fetchall()
        print(data)

        # Get data from db
        cur.execute("SELECT SurveyID, Date, TotalScore, PatientID FROM Survey WHERE PatientID=? ;", [patient_id])
        Surv = cur.fetchall()
        print(Surv)

        # Get data from db
        cur.execute("SELECT UserAnswerID, AnswerID, AnswerScore, SurveyID, AnswerText, PatientID FROM UserAnswer WHERE PatientID=? ;", [patient_id])
        Usans = cur.fetchall()
        print(Usans)

    except Exception as exception:
        print('there was an error', exception)
    finally:
        conn.close()
        return render_template('ViewPatient.html', data = data, Surv = Surv, Usans = Usans)

################################################################################
# Process pateient login
@app.route("/FormProcessing", methods=['GET' ,'POST'])
def Formprocesst():
    # get form data
    if request.method== 'GET':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        print("Processing")

        return render_template('registration.html')

    # get data from form
    if request.method== 'POST':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('psw', default="Error")
        print(Email, Password)

        # get data from db
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT Email, Password, PatientID  FROM Patient WHERE Email=? AND Password=?",[Email,Password])
        Patient_data= cur.fetchall()
        conn.close()

        if Patient_data != []:
            # If succesful login create a ID cookie and render welcome page
            if Email == Patient_data[0][0] and Password == Patient_data[0][1]:
                resp = make_response(render_template('WelcomePage.html'))
                resp.set_cookie('PatientID', str(Patient_data[0][2]))
                return resp

        return render_template('registration.html')

################################################################################
# Process the client registration
@app.route("/Form", methods=['GET', 'POST'])
def getpatient():
    if request.method == 'GET':
        return render_template('registration.html')

    # Retrive for data
    if request.method == 'POST':
        FirstName = request.form.get('FirstName', default="Error")
        SurName = request.form.get('SurName', default="Error")
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        Age = request.form.get('Age', default="Error")
        Gender= request.form.get('Gender', default="Error")
        print("inserting "+FirstName)

        #save data to database
        try:
            conn = sqlite3.connect(DATABASE)
            cur = conn.cursor()
            cur.execute("INSERT INTO Patient ('FirstName','SurName','Email','Password','Age','Gender')\
                        VALUES (?,?,?,?,?,?)",(FirstName,SurName,Email,Password,Age,Gender))
            conn.commit()
            msg = "Record successfully added, Please login"

        except:
            conn.rollback()
            msg = "error in insert operation"
        finally:
            conn.close()
            return msg

################################################################################
# Resnder the welcome page
@app.route("/Welcome", methods=['GET'])
def getWelcome():
    if request.method== 'GET':
        return render_template('WelcomePage.html')

################################################################################
# Save last page of survey answers and creates a survey db entry with data
@app.route("/Thankyou")
def getThankYou():

    # Get data to initilizes a survey record
    answerData = getDBData("SELECT * FROM Answer;")
    UanswerData = getDBData("SELECT AnswerScore, SurveyID FROM UserAnswer;")
    UanswerDataArray = []

    # Cal user score
    for elementArray in UanswerData:
        UanswerDataArray.append(int(elementArray[0]))
    Score = sum(UanswerDataArray)

    serveySave(answerData) # save last user answers

    # Add survey record
    date = str(datetime.datetime.now())
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    cur.execute("INSERT INTO Survey ('Date','TotalScore','PatientID')\
                VALUES (?,?,?)",(date,Score,int(request.cookies.get('PatientID'))))
    conn.commit()
    conn.close()

    return render_template('ThankYoupage.html')

################################################################################
# Saves last page of answers, retrives the next questions and answers for survey
@app.route("/Survey/<NumT>", methods=['GET'])
def getSurvey(NumT):
    if request.method== 'GET':
        try:
            # get next section of questions and save previous answers
            QuestGroup = int(NumT)
            QuestGroup +=1
            questionData = getDBData(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
            answerData = getDBData("SELECT * FROM Answer;")
            serveySave(answerData)

            # If initilising the servey get a servey Id
            if(QuestGroup == 1):
                conn = sqlite3.connect(DATABASE)
                cur = conn.cursor()
                cur.execute("SELECT SurveyID FROM Survey;")
                Data = cur.fetchall()
                conn.close()

                DataArray = []
                for elementArray in Data:
                    DataArray.append(elementArray[0])
                SurveyId = (int(DataArray[-1])+1)

                # Set survey Id into cookie
                resp = make_response(render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup))
                resp.set_cookie('SurveyID', str(SurveyId))
                return resp

            # Render next survey page, load survey end for last set fo questions
            if(QuestGroup<15):
                return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

            else:
                return render_template('SurveyEnd.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

        except:
            return 'there was an error'

################################################################################
# Retrives last page of questions and answers
@app.route("/SurveyB/<NumT>")
def getSurveyB(NumT):
    try:
        QuestGroup = int(NumT)
        QuestGroup -=1  # Change questions seen

        # load questions and answers for the next page
        questionData = getDBData(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
        answerData = getDBData("SELECT * FROM Answer;")
        serveySave(answerData)
        return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

    except:
        return 'there was an error'

################################################################################
# Gets data from the database
def getDBData(iString):
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    cur.execute(iString)
    Data = cur.fetchall()
    conn.close()
    return Data

################################################################################
# Saves the UserAnswers to the database
def serveySave(answerData):
    try:
        data = request.args.to_dict()
        tempAnswerData = answerData

        # Gets data from url as a dictinary
        for key, value in data.items():

            if (data != None):  # only process if there is an entry

                # Loops through possible answercomparing AnswerID's to find user answer data
                for elementArray in tempAnswerData:
                    if (str(elementArray[0]) == value):

                        # Save the UserAnswer in the database
                        print(elementArray[0],elementArray[2],5,elementArray[1], request.cookies.get('PatientID'))
                        conn = sqlite3.connect(DATABASE)
                        cur = conn.cursor()
                        cur.execute("INSERT INTO UserAnswer ('AnswerID','AnswerScore','SurveyID','AnswerText','PatientID')\
                                    VALUES (?,?,?,?,?)",(elementArray[0],elementArray[2],int(request.cookies.get('SurveyID')),elementArray[1],int(request.cookies.get('PatientID'))))
                        conn.commit()
                        conn.close()

    except:
        conn.rollback()
        conn.close()

################################################################################
# Runs flask server
if __name__ == "__main__":
    app.run(debug=True)
