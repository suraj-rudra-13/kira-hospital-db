from flask import Flask, render_template, request, redirect
import mysql.connector as myc

db = myc.connect(
    host="hospital-db.c9nzenfd5ofs.ap-south-1.rds.amazonaws.com",
    user="kira",
    password="kira1801",
    database="horizon"
)

cursor = db.cursor()

app = Flask("hospital")

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/admin')
def admin():
    return render_template('admin_login.html')

@app.route('/doctor')
def doctor():
    return render_template('doctor_login.html')

@app.route('/doctor/treatments', methods=['POST'])
def treatments():
    if request.method == 'POST':
        username = "101" #to be extracted from db later 
        pasw = "doctor" #to be extracted from db later
        if(request.form.get('username') == username and request.form.get('password') == pasw):
            return redirect(f'/doctor/treatments/details/{username}')
        else:
            return redirect('/doctor')
    else:
        return render_template('doctor_login.html')

@app.route('/doctor/treatments/details/<string:user>')
def details(user):
    query = f"select * from treats where doctor_id = {user} "
    cursor.execute(query)
    result = cursor.fetchall()
    for i in result:
        print("1")
        print(i)
    return render_template('treatments.html', cursors = result )

if __name__ == "__main__":
    app.run(debug=True)