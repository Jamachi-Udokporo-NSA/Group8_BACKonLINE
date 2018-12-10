import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)
DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
QuestGroup = 0


@app.route("/First", methods=['GET'])
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
        cur.execute("SELECT Email, Password FROM Staff WHERE Email=? AND Password=?",[Email,Password])
        Login_admin= cur.fetchall()
        conn.close()
        print(Login_admin)
        if Login_admin != []:
            if Email == Login_admin[0][0] and Password == Login_admin[0][1]:
                return render_template('Select_patient_answer.html')
        return render_template('Admin.html')

@app.route("/Select", methods=['GET', 'POST'])
def getSelect():
    if request.method== 'GET':
        return render_template('Select_patient_answer.html')
    if request.method =='POST':
        try:
                PatientID = request.form.get('PatientID', default="Error") #rem: args for get form for post
                conn = sqlite3.connect(DATABASE)
                cur = conn.cursor()
                cur.execute("SELECT PatientID, FirstName, SurName, Email, Age, Gender FROM Patient WHERE PatientID=? ;", [PatientID])
                data = cur.fetchall()
                print(data)
                cur.execute("SELECT SurveyID, Date, TotalScore, PatientID FROM Survey WHERE PatientID=? ;", [PatientID])
                Surv = cur.fetchall()
                print(Surv)
                cur.execute("SELECT UserAnswerID, AnswerID, AnswerScore, SurveyID, AnswerText, PatientID FROM UserAnswer WHERE PatientID=? ;", [PatientID])
                Usans = cur.fetchall()
                print(Usans)
        except:
                print('there was an error', data)
                conn.close()
        finally:
                conn.close()
                # return str(data)
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
        cur.execute("SELECT Email, Password FROM Patient WHERE Email=? AND Password=?",[Email,Password])
        Patient_data= cur.fetchall()
        conn.close()
        print(Patient_data)
        if Patient_data != []:
            if Email == Patient_data[0][0] and Password == Patient_data[0][1]:
                return render_template('WelcomePage.html')
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
            msg = "Record successfully added"
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
    return render_template('ThankYoupage.html')

@app.route("/Survey/<NumT>", methods=['GET'])
def getSurvey(NumT):
    if request.method== 'GET':
        try:
            QuestGroup = int(NumT)
            QuestGroup +=1

            conn = sqlite3.connect(DATABASE)
            cur = conn.cursor()
            cur.execute(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
            questionData = cur.fetchall()
            conn.close()

            conn = sqlite3.connect(DATABASE)
            cur = conn.cursor()
            cur.execute("SELECT * FROM Answer;")
            answerData = cur.fetchall()
            conn.close()

            print("---------------------------------------------------------------")
            try:
                data = request.args.to_dict()
                tempAnswerData = answerData

                for key, value in data.items():
                    try:
                        if (data != None):

                            try:
                                print(key, value)

                                for elementArray in tempAnswerData:
                                    if (str(elementArray[0]) == value):
                                        print(elementArray)

                                        try:
                                            conn = sqlite3.connect(DATABASE)
                                            cur = conn.cursor()
                                            cur.execute("INSERT INTO UserAnswer ('AnswerID','AnswerScore','SurveyID','AnswerText','PatientID')\
                                                        VALUES (?,?,?,?,?)",(elementArray[0],elementArray[2],5,elementArray[1],5))
                                            conn.commit()
                                            msg = "Record successfully added"
                                        except:
                                            conn.rollback()
                                            msg = "error in insert operation"
                                        finally:
                                            conn.close()

                            except Exception as e:
                                print("First", e)

                                pass # code for text entry

                    except:

                        print("Second")
                        pass
            except:
                print("Third")
                pass
            print("---------------------------------------------------------------")

            if(QuestGroup<15):
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

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute(f"SELECT * FROM Question WHERE QuestionGroup == {QuestGroup};")
        questionData = cur.fetchall()
        conn.close()

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Answer;")
        answerData = cur.fetchall()
        conn.close()

        if(QuestGroup<16):
            return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

        else:
            return render_template('SurveyEnd.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

    except:
        return 'there was an error'


if __name__ == "__main__":
    app.run(debug=True)
