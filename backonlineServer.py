import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3
import datetime

app = Flask(__name__)
DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
QuestGroup = 0


@app.route("/", methods=['GET'])
def getFirst():
    if request.method== 'GET':
        return render_template('First.html')

@app.route("/Admin", methods=['GET'])
def getAdmin():
    if request.method== 'GET':
        return render_template('Admin.html')

@app.route("/Process", methods=['GET', 'POST'])
def AllAdmin():
    if request.method== 'GET':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        print("Validating")
        return render_template('Admin.html')

    if request.method == 'POST':
        Email = request.form.get('email', default="Error")
        Password = request.form.get('psw', default="Error")
        print(Email, Password)

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT PatientID, FirstName, SurName, Email, Age, Gender FROM Patient;")
        dispat = cur.fetchall()
        print(dispat)

        cur.execute("SELECT Email, Password FROM Staff WHERE Email=? AND Password=?",[Email,Password])
        Login_admin= cur.fetchall()
        conn.close()
        print(Login_admin)

        if Login_admin != []:
            if Email == Login_admin[0][0] and Password == Login_admin[0][1]:
                return render_template('Select_patient.html', dispat= dispat)
        return render_template('Admin.html')

@app.route("/Select/<patient_id>", methods=['GET', 'POST'])
def getSelect(patient_id):
    # if request.method== 'GET':
    #     return render_template('Select_patient.html')
    # if request.method =='POST':
    try:
        # PatientID = request.form.get('PatientID', default="Error") #rem: args for get form for post
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT PatientID, FirstName, SurName, Email, Age, Gender FROM Patient WHERE PatientID=? ;", [patient_id])
        data = cur.fetchall()
        print(data)
        cur.execute("SELECT SurveyID, Date, TotalScore, PatientID FROM Survey WHERE PatientID=? ;", [patient_id])
        Surv = cur.fetchall()
        print(Surv)
        cur.execute("SELECT UserAnswerID, AnswerID, AnswerScore, SurveyID, AnswerText, PatientID FROM UserAnswer WHERE PatientID=? ;", [patient_id])
        Usans = cur.fetchall()
        print(Usans)
    except Exception as exception:
        print('there was an error', exception)
    finally:
        conn.close()
        return render_template('ViewPatient.html', data = data, Surv = Surv, Usans = Usans)

# @app.route("/ViewPatient", methods=['GET', 'POST'])
# def getinfo():
#     if request.method== 'GET':
#         return render_template('ViewPatient.html')

@app.route("/FormProcessing", methods=['GET' ,'POST'])
def Formprocesst():
    if request.method== 'GET':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        print("Processing")

        return render_template('registration.html')

    if request.method== 'POST':
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('psw', default="Error")
        print(Email, Password)

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT Email, Password, PatientID  FROM Patient WHERE Email=? AND Password=?",[Email,Password])
        Patient_data= cur.fetchall()
        conn.close()

        if Patient_data != []:
            if Email == Patient_data[0][0] and Password == Patient_data[0][1]:
                resp = make_response(render_template('WelcomePage.html'))
                resp.set_cookie('PatientID', str(Patient_data[0][2]))
                return resp

        return render_template('registration.html')


@app.route("/Form", methods=['GET', 'POST'])
def getpatient():
    if request.method == 'GET':
        return render_template('registration.html')
    if request.method == 'POST':
        FirstName = request.form.get('FirstName', default="Error")
        SurName = request.form.get('SurName', default="Error")
        Email = request.form.get('Email', default="Error")
        Password = request.form.get('Password', default="Error")
        Age = request.form.get('Age', default="Error")
        Gender= request.form.get('Gender', default="Error")
        print("inserting "+FirstName)
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

@app.route("/Welcome", methods=['GET'])
def getWelcome():
    if request.method== 'GET':
        return render_template('WelcomePage.html')

@app.route("/Thankyou")
def getThankYou():
    answerData = getDBData("SELECT * FROM Answer;")
    UanswerData = getDBData("SELECT AnswerScore, SurveyID FROM UserAnswer;")
    UanswerDataArray = []

    for elementArray in UanswerData:
        UanswerDataArray.append(int(elementArray[0]))

    Score = sum(UanswerDataArray)

    serveySave(answerData)

    date = str(datetime.datetime.now())
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    cur.execute("INSERT INTO Survey ('Date','TotalScore','PatientID')\
                VALUES (?,?,?)",(date,Score,int(request.cookies.get('PatientID'))))
    conn.commit()
    conn.close()

    return render_template('ThankYoupage.html')

@app.route("/Survey/<NumT>", methods=['GET'])
def getSurvey(NumT):
    if request.method== 'GET':
        try:
            QuestGroup = int(NumT)
            QuestGroup +=1

            questionData = getDBData(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
            answerData = getDBData("SELECT * FROM Answer;")

            serveySave(answerData)

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

                resp = make_response(render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup))
                resp.set_cookie('SurveyID', str(SurveyId))
                return resp

            elif(QuestGroup<15):
                return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

            else:
                return render_template('SurveyEnd.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

        except:
            return 'there was an error'


@app.route("/SurveyB/<NumT>")
def getSurveyB(NumT):
    try:
        QuestGroup = int(NumT)
        QuestGroup -=1

        questionData = getDBData(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
        answerData = getDBData("SELECT * FROM Answer;")
        serveySave(answerData)
        return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

    except:
        return 'there was an error'

def getDBData(iString):
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    cur.execute(iString)
    Data = cur.fetchall()
    conn.close()
    return Data

def serveySave(answerData):
    try:
        data = request.args.to_dict()
        tempAnswerData = answerData

        for key, value in data.items():
            if (data != None):
                for elementArray in tempAnswerData:
                    if (str(elementArray[0]) == value):
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


if __name__ == "__main__":
    app.run(debug=True)
