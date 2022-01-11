from flask import Flask, request, redirect, render_template
app = Flask(__name__)

@app.route('/')
def hello_world():
    title = "Media Center"
    name = "Audren"
    return render_template('index.html', title=title, name=name)

reseaux_user = []
@app.route('/signup', methods = ['POST'])
def signup():
    reseaux = request.form['reseaux']
    reseaux_user.append(reseaux)
    print(reseaux_user)
    return redirect('/')

@app.route('/reseaux.html')
def emails():
    return render_template('reseaux.html', reseaux_user=reseaux_user)

if __name__ == "__main__":
    app.run()
