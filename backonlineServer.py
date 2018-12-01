import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)

@app.route("/login", methods=['GET'])
def getlogin():
    if request.method== 'GET':
        return render_template('registration.html')


DATABASE = 'Database/backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
QuestGroup = 0
# @app.route("/Main", methods=['GET'])
# def returnFirst():
#     if request.method == 'GET':
#         return render_template('Template.html')


@app.route("/Survey")
def getSurvey():
    global QuestGroup

    try:
        QuestGroup += 1
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

        if(QuestGroup<15):
            return render_template('Survey.html',questionData = questionData, answerData= answerData)

        else:
            QuestGroup -= 1
            return render_template('SurveyEnd.html',questionData = questionData, answerData= answerData)

    except:
        return 'there was an error'

if __name__ == "__main__":
    app.run(debug=True)
