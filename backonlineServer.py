import os
from flask import Flask, redirect, request, render_template, make_response, escape, session
import sqlite3

DATABASE = 'Database/backonlineDatabase.db'

app = Flask(__name__)

ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

@app.route("/Admin")
def admin():
    username = request.cookies.get('username')
    return render_template('Admin.html', msg = '', username = username)

# =======================================================================
#      the db creation methods
def deleteTables():
    conn = sqlite3.connect(DATABASE)
    conn.execute('DROP TABLE IF EXISTS Jobs')
    conn.execute('DROP TABLE IF EXISTS Orders')
    conn.execute('DROP TABLE IF EXISTS Customers')
    conn.close()

if __name__ == "__main__":
    pass
