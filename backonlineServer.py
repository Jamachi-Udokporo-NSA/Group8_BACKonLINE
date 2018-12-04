import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)
DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
QuestGroup = 0

# @app.route("/Form", methods=['GET'])
# def getlogin():
#     if request.method== 'GET':
#         return render_template('registration.html')

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

@app.route("/Survey/<NumT>")
def getSurvey(NumT):
    try:
        QuestGroup = int(NumT)
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

        QuestGroup +=1

        if(QuestGroup<16):
            return render_template('Survey.html',questionData = questionData, answerData= answerData, questionNumber = QuestGroup)

        else:
            return render_template('SurveyEnd.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

if __name__ == "__main__":
    app.run(debug=True)
