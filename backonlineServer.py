import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)

DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

@app.route("/Main", methods=['GET'])
def returnFirst():
    if request.method == 'GET':
        return render_template('Template.html')

@app.route("/Welcome", methods = ['GET'])
def returnwel():
        if request.method == 'GET':
                return render_template('WelcomePage.html')

@app.route("/SurveyA")
def getSurveyA():
    try:
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Question WHERE QuestionID BETWEEN 1 AND 22;")
        questionData = cur.fetchall()
        conn.close()

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Answer WHERE QuestionID BETWEEN 1 AND 22; ")
        answerData = cur.fetchall()
        conn.close()

        return render_template('SurveyAPainBehaviour.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

@app.route("/SurveyB")
def getSurveyB():
    try:
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Question WHERE QuestionID BETWEEN 23 AND 28; ")
        questionData = cur.fetchall()
        conn.close()

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Answer WHERE QuestionID BETWEEN 23 AND 28; ")
        answerData = cur.fetchall()
        conn.close()

        return render_template('SurveyBBackPainAndWork.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

@app.route("/SurveyC")
def getSurveyC():
    try:
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Question WHERE QuestionID BETWEEN 29 AND 32;")
        questionData = cur.fetchall()
        conn.close()

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Answer WHERE QuestionID BETWEEN 29 AND 32; ")
        answerData = cur.fetchall()
        conn.close()

        return render_template('SurveyCBackPainAndLifestyle.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

@app.route("/SurveyD")
def getSurveyD():
    try:
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Question WHERE QuestionID BETWEEN 33 AND 39; ")
        questionData = cur.fetchall()
        conn.close()

        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Answer WHERE QuestionID BETWEEN 33 AND 39; ")
        answerData = cur.fetchall()
        conn.close()

        return render_template('SurveyDPerceptionOfBackPain.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

@app.route("/Thank", methods = ['GET'])
def returnthank():
        if request.method == 'GET':
                return render_template ('Thankyoupage.html')

if __name__ == "__main__":
    app.run(debug=True)
