from flask import Flask, request, redirect, render_template, g
from flask_login import login_user, logout_user, current_user, login_required
import sqlite3
from forms import LoginForm
app = Flask(__name__)

@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html', title="Home")
reseaux_user = []

@app.route('/signup', methods = ['POST'])
def signup():
    reseaux = request.form['reseaux']
    reseaux_user.append(reseaux)
    print(reseaux_user)
    g.db.execute("INSERT INTO reseaux_user VALUES (?)", [reseaux])
    g.db.commit()
    return redirect('/')
users = []
@app.route('/login', methods = ['POST'])
def login():
    user = request.form['user']
    users.append(user) 
    g.db.execute("insert into users user values (?)",(user))

@app.route('/reseaux')
def emails():
    reseaux_user = g.db.execute("SELECT reseaux FROM reseaux_user").fetchall()
    return render_template('reseaux.html', reseaux_user=reseaux_user)

@app.before_request
def before_request():
    g.db = sqlite3.connect("reseaux.db")

@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'db'):
        g.db.close()


if __name__ == "__main__":
    app.run()
