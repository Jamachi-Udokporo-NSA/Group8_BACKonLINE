import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)

DATABASE = 'backonlinedatabase.db'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

@app.route("/Main", methods=['GET'])
def returnFirst():
        if request.method == 'GET':
                return render_template('Template.html')

def fetchingdata():
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute('select* from Question, where QuestionID = "1"' )
        data = cur.fetchall()
       
                

if __name__ == "__main__":
    app.run(debug=True)
