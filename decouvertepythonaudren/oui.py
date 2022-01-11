from flask import Flask, request, redirect, render_template
app = Flask(__name__)

@app.route('/')
def hello_world():
    author = "Charles Dickens"
    name = "Audren"
    return render_template('index.html', author=author, name=name)

email_addresses = []
@app.route('/signup', methods = ['POST'])
def signup():
    email = request.form['email']
    email_addresses.append(email)
    print(email_addresses)
    return redirect('/')

@app.route('/emails.html')
def emails():
    return render_template('emails.html', email_addresses=email_addresses)

if __name__ == "__main__":
    app.run()
