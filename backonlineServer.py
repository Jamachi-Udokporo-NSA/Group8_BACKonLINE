import os
from flask import Flask, redirect, request, render_template, make_response, escape, session, jsonify
import sqlite3

app = Flask(__name__)

ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

@app.route("/Main", methods=['GET'])
def returnFirst():
        if request.method == 'GET':
                return render_template('Template.html')

if __name__ == "__main__":
    app.run(debug=True)
