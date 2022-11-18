
import json
import os
from typing import Sequence
import psycopg2
from flask import Flask, render_template, request, flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Sequence, create_engine
from datetime import datetime
import pandas as pd
from flask_bootstrap import Bootstrap5
from flask import Flask, session



app = Flask(__name__)
bootstrap = Bootstrap5(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost/postgres'
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.secret_key = 'secret string'
db = SQLAlchemy(app)
engine = create_engine('postgresql://postgres:1234@localhost/postgres')


# Creating Models to map it to the Entity in DB

class authorize(db.Model):
    a_id = db.Column(db.Integer,primary_key=True, nullable=False)
    u_id = db.Column(db.Integer)
    v_id = db.Column(db.Integer)


    def __init__(self, a_id, u_id, v_id):
        self.a_id = a_id
        self.u_id = u_id
        self.v_id = v_id

class driver(db.Model):
    driver_id = db.Column(db.Integer,primary_key=True, nullable=False)
    u_id = db.Column(db.Integer)
    license = db.Column(db.String(120), nullable=False)

    def __init__(self, driver_id, u_id, license):
        self.driver_id = driver_id
        self.u_id = u_id
        self.license = license

class driver_rides(db.Model):
    driver_id = db.Column(db.Integer,primary_key=True, nullable=False)
    ride_id = db.Column(db.Integer, nullable=False)

    def __init__(self, driver_id, ride_id):
        self.driver_id = driver_id
        self.ride_id = ride_id

class passenger(db.Model):
    p_id = db.Column(db.Integer,primary_key=True, nullable=False)
    u_id = db.Column(db.Integer)
    p_address = db.Column(db.String(120), nullable=False)

    def __init__(self, p_id, u_id, p_address):
        self.p_id = p_id
        self.u_id = u_id
        self.p_address = p_address

class passenger_ride(db.Model):
    p_id = db.Column(db.Integer,primary_key=True, nullable=False)
    ride_id = db.Column(db.Integer, nullable=False)

    def __init__(self, p_id, ride_id, p_address):
        self.p_id = p_id
        self.ride_id = ride_id

class reviews(db.Model):
    review_id = db.Column(db.Integer,primary_key=True, nullable=False)
    driver_review = db.Column(db.Integer)
    passenger_review = db.Column(db.String(120), nullable=False)

    def __init__(self, review_id, driver_review, passenger_review):
        self.review_id = review_id
        self.driver_review = driver_review
        self.passenger_review = passenger_review

class ride(db.Model):
    r_id = db.Column(db.Integer,primary_key=True, nullable=False)
    r_date = db.Column(db.Date, nullable=False) #date.today().strftime("%Y-%m-%d")
    r_time = db.Column(db.DateTime, nullable=False)
    r_from = db.Column(db.String(120))
    r_to = db.Column(db.String(120))
    v_id = db.Column(db.Integer, nullable=False)
    r_fee = db.Column(db.Integer, nullable=False)
    driver_id = db.Column(db.Integer, nullable=False)
    p_id = db.Column(db.Integer, nullable=False)
    review_id = db.Column(db.Integer, nullable=False)


    def __init__(self, r_id, r_date, r_time, r_from, r_to, v_id,r_fee, driver_id, p_id, review_id):
        self.r_id = r_id
        self.r_date = r_date
        self.r_time = r_time
        self.r_from = r_from
        self.r_to = r_to
        self.v_id = v_id
        self.r_fee = r_fee
        self.driver_id = driver_id
        self.p_id = p_id
        self.review_id = review_id

    def to_dict(self):
        return {
            'r_id': self.r_id,
            'r_date': self.r_date,
            'r_time': self.r_time,
            'r_from': self.r_from,
            'r_to': self.r_to,
            'v_id': self.v_id,
            'r_fee': '$'+ str(self.r_fee),
            'driver_id': self.driver_id,
            'p_id': self.p_id,
            'review_id': self.review_id
        }

class users(db.Model):
    u_id = db.Column(db.Integer, primary_key=True)
    u_name = db.Column(db.String(80), unique=True, nullable=False)
    u_email = db.Column(db.String(120), nullable=False)
    u_password = db.Column(db.String(120), nullable=False)
    u_phone = db.Column(db.String(120), nullable=False)


    def __init__(self,  u_name, u_email,u_password,u_phone):
        # self.u_id = u_id
        self.u_name = u_name
        self.u_email = u_email
        self.u_password = u_password
        self.u_phone = u_phone

class vehicle(db.Model):
    v_id = db.Column(db.Integer, primary_key=True, nullable=False)
    model = db.Column(db.String(80), unique=True)
    capacity = db.Column(db.Integer, nullable=False)
    license_plate = db.Column(db.String(120),unique=True, nullable=False)
    color = db.Column(db.String(120), unique=True, nullable=False)


    def __init__(self, v_id, model, capacity,license_plate,color):
        self.v_id = v_id
        self.model = model
        self.capacity = capacity
        self.license_plate = license_plate
        self.color = color


# Routes

@app.route("/")
def home():
    return render_template('index.html')


@app.route("/addauth", methods=['POST'])
def addauth():
    a_id = request.form["a_id"]
    u_id = request.form["u_id"]
    v_id = request.form["v_id"]
    entry = authorize(a_id, u_id, v_id)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/addDriver", methods=['POST'])
def addDriver():
    driver_id = request.form["driver_id"]
    u_id = request.form["u_id"]
    license = request.form["license"]
    entry = driver(driver_id, u_id, license)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/driverrides", methods=['POST'])
def driver_rides():
    driver_id = request.form["driver_id"]
    ride_id = request.form["ride_id"]
    entry = driver_rides(driver_id, ride_id)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/addpassenger", methods=['POST'])
def addpassenger():
    p_id = request.form["p_id"]
    u_id = request.form["u_id"]
    p_address = request.form["p_address"]

    entry = passenger(p_id, u_id, p_address)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/passengerride", methods=['POST'])
def passenger_ride():
    p_id = request.form["p_id"]
    ride_id = request.form["ride_id"]
    entry = passenger_ride(p_id, ride_id)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/reviews", methods=['POST'])
def saveReviews():
    rev_seq = Sequence('rev_id_seq') 
    review_id = rev_seq.next_value()
    driver_review = request.form["driver_review"]
    passenger_review = request.form["passenger_review"]
    entry = reviews(review_id, driver_review, passenger_review)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Review saved successfully!"
    return render_template('index.html', hasMessage = True, messageBody=messageBody)

@app.route("/addReview")
def addReview():
    if  session['loggedIn'] == True:
        return render_template('addReview.html')
    else:
        return render_template('login.html', hasMessage = True, messageBody="Please login to add a Review")
@app.route("/saveRide", methods=['POST'])
def saveRide():
    ride_seq = Sequence('ride_id_seq') 
    r_id = ride_seq.next_value()
    r_date = request.form["r_date"]
    #db.Column(db.DateTime, default=datetime.now())
    r_time = datetime.now()
    r_from = request.form["r_from"]
    r_to = request.form["r_to"]
    v_id = request.form["v_id"]
    r_fee = request.form["r_fee"]
    driver_id = request.form["driver_id"]
    p_id = 1
    review_id = 1

    entry = ride( r_id, r_date, r_time, r_from, r_to, v_id,r_fee, driver_id, p_id, review_id)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Successfully added the request"
    return render_template('index.html', hasMessage = True, messageBody=messageBody)

@app.route("/addRide")
def addRide():
    if  session['loggedIn'] == True:
        return render_template('addRide.html')
    else:
        return render_template('login.html', hasMessage = True, messageBody="Please login to add a new Ride")
        

@app.route("/ridesData")
def ridesData():
    my_dictionary = {'data': [ride_.to_dict() for ride_ in ride.query]}
    return json.dumps(my_dictionary, indent=4, sort_keys=True, default=str)

@app.route("/rides")
def Rides():
    return render_template('index.html')

@app.route("/register")
def SignUpPage():
    return render_template('signup.html')


@app.route("/adduser", methods=['POST'])
def adduser():
    veh_seq = Sequence('test_id_seq') 
    u_id = veh_seq.next_value()
    u_name = request.form["u_name"]
    u_email = request.form["u_email"]
    u_pasword = request.form["u_pasword"]
    u_phone = request.form["u_phone"]
    entry = users( u_name, u_email,u_pasword,u_phone)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Registration successful"
    return render_template('index.html', hasMessage = True, messageBody=messageBody)


@app.route("/login")
def LoginPage():
    return render_template('login.html')


@app.route("/validateLogin", methods=['POST'])
def validateLogin():
    u_name_ = request.form["u_name"]
    u_pasword_ = request.form["u_pasword"]
    user_ = users.query.filter_by(u_name=u_name_).first()
    loginSuccess = (user_.u_password == u_pasword_)
    str = ""
    if loginSuccess:
        str = "Welcome " + u_name_ + "!"
        session['userid'] = user_.u_id
        session['loggedIn'] = True
    else:
        str = "Authentication Failed!"

    return render_template('index.html', hasMessage = True, messageBody=str)

@app.route("/SignOut")
def SignOut():
    session['userid'] = ''
    session['loggedIn'] = False
    return render_template('index.html')

@app.route("/addvehicle", methods=['POST'])
def add_vehicle():
    veh_seq = Sequence('veh_reg_seq') 
    v_id = veh_seq.next_value()
    model = request.form["model"]
    capacity = request.form["capacity"]
    license_plate = request.form["license_plate"]
    color = request.form["color"]
    entry = vehicle(v_id, model, capacity,license_plate,color)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Vehicle added successfully"
    return render_template('index.html', hasMessage = True, messageBody=messageBody)

@app.route("/vehicleRegister")
def vehicleRegister():
    if  session['loggedIn'] == True:
        return render_template('vehicleRegister.html')
    else:
        return render_template('login.html', hasMessage = True, messageBody="Please login to add a new Vehicle")


 