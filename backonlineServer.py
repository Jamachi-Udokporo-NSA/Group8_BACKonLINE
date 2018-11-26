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

@app.route("/Getdata")
def fetchingdata():
    try:
        conn = sqlite3.connect(DATABASE)
        cur = conn.cursor()
        cur.execute("SELECT * FROM Question;")
        data = cur.fetchall()
        print(data)
        return render_template('Template.html', data = data)

    except:
        print('there was an error')
        return str(data)

    finally:
        conn.close()



if __name__ == "__main__":
    app.run(debug=True)
