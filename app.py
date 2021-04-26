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
    query = f"select treats.patient_id, patient.first_name from treats inner join patient on patient.patient_id = treats.patient_id where treats.doctor_id={user}"
    cursor.execute(query)
    result = cursor.fetchall()
    query = f"select first_name from doctor where doctor_id ={user}"
    cursor.execute(query)
    doctor_name = cursor.fetchall()[0][0]
    return render_template('treatments.html', result = result, doctor_name = doctor_name )


@app.route('/medicine/<string:pid>')
def medicine(pid):
    query = "select * from medicine"
    query1 = f"select first_name from patient where patient_id={pid}"
    cursor.execute(query)
    medicine_list = cursor.fetchall()
    cursor.execute(query1)
    pname = cursor.fetchall()[0][0]
    return render_template("medicine_update.html",medicine_list = medicine_list, pid=pid, name=pname)


@app.route('/medicine/update/<string:pid>', methods=["POST"])
def med_update(pid):
    med_list = request.form.getlist('medicine')
    for i in med_list:
        query = f"select price from medicine where code={i}"
        cursor.execute(query)
        price = cursor.fetchall()[0][0]
        print(price)
        query1=f"insert into bills values({pid},{i},{price})"
        cursor.execute(query1)
        db.commit()
    return "Done updation. <a href='/' >back to mainmenu</a>"


@app.route('/patient')
def patient():
    return render_template("patient_register.html")

@app.route('/patient/bills', methods=["POST"])
def bills():
    pid = request.form.get("pid")
    query1 = f"select first_name from patient where patient_id ={pid}"
    cursor.execute(query1)
    patient_name = cursor.fetchall()[0][0]
    query = f"select doctor_id from treats where patient_id={pid}"
    cursor.execute(query)
    doc_id = cursor.fetchall()[0][0]
    query = f"select first_name from doctor where doctor_id ={doc_id}"
    cursor.execute(query)
    doctor_name = cursor.fetchall()[0][0]
    query = f"select * from bills where patient_id={pid}"
    cursor.execute(query)
    result = cursor.fetchall()
    bill_proc = f"call getBill({pid})"
    cursor.execute(bill_proc)
    bill = cursor.fetchall()[0][0]
    return render_template("yourbill.html", result = result, patient=patient_name,doctor=doctor_name, bill=bill)


if __name__ == "__main__":
    app.run(debug=True)
