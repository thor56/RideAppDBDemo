
import json
import os
from typing import Sequence
import psycopg2
from flask import Flask, render_template, request, flash, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Sequence, create_engine
from datetime import datetime
import pandas as pd
from flask_bootstrap import Bootstrap5
from flask import Flask, session




app = Flask(__name__)
bootstrap = Bootstrap5(app)

# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost/postgres'
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get("DATABASE_URL1")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.secret_key = 'secret string'
db = SQLAlchemy(app)
# engine = create_engine('postgresql://postgres:1234@localhost/postgres')
# # engine = create_engine(os.environ.get("DATABASE_URL1"))

# session['loggedIn'] = False

# Creating Models to map it to the Entity in DB

class authorize(db.Model):
    a_id = db.Column(db.Integer, db.Sequence('aith_id_seq'), primary_key=True, nullable=False)
    u_id = db.Column(db.Integer, db.ForeignKey('users.u_id'))
    v_id = db.Column(db.Integer, db.ForeignKey('vehicle.v_id'))


    def __init__(self, u_id, v_id):
        self.u_id = u_id
        self.v_id = v_id

    def to_dict(self):
        return {
            'a_id': self.a_id,
            'u_id': self.u_id,
            'v_id': self.v_id
        }

class driver(db.Model):
    driver_id = db.Column(db.Integer, db.Sequence('driver_id_seq'), primary_key=True, nullable=False)
    u_id = db.Column(db.Integer)
    license = db.Column(db.String(120), nullable=False)

    def __init__(self, u_id, license):
        self.u_id = u_id
        self.license = license

    def to_dict(self):
        return {
            'driver_id' : self.driver_id,
            'u_id': self.u_id,
            'license': self.license
        }

class driver_rides(db.Model):
    driver_id = db.Column(db.Integer,primary_key=True, nullable=False)
    ride_id = db.Column(db.Integer, nullable=False)

    def __init__(self, driver_id, ride_id):
        self.driver_id = driver_id
        self.ride_id = ride_id

class passenger(db.Model):
    p_id = db.Column(db.Integer, db.Sequence('pass_id_seq'), primary_key=True, nullable=False)
    u_id = db.Column(db.Integer)
    p_address = db.Column(db.String(120), nullable=False)

    def __init__(self, u_id, p_address):
        self.u_id = u_id
        self.p_address = p_address

class passenger_ride(db.Model):
    p_id = db.Column(db.Integer, primary_key=True, nullable=False)
    ride_id = db.Column(db.Integer)

    def __init__(self, p_id, ride_id):
        self.p_id = p_id
        self.ride_id = ride_id



class reviews(db.Model):
    review_id = db.Column(db.Integer, db.Sequence('rev_id_seq'), primary_key=True, nullable=False)
    driver_review = db.Column(db.Integer)
    passenger_review = db.Column(db.String(120), nullable=False)

    def __init__(self, driver_review, passenger_review):
        self.driver_review = driver_review
        self.passenger_review = passenger_review

class ride(db.Model):
    r_id = db.Column(db.Integer,db.Sequence('ride_id_seq'), primary_key=True, nullable=False)
    r_date = db.Column(db.Date, nullable=False) #date.today().strftime("%Y-%m-%d")
    r_time = db.Column(db.DateTime, nullable=False)
    r_from = db.Column(db.String(120))
    r_to = db.Column(db.String(120))
    v_id = db.Column(db.Integer, nullable=False)
    r_fee = db.Column(db.Integer, nullable=False)
    driver_id = db.Column(db.Integer, nullable=False)
    p_id = db.Column(db.Integer, nullable=False)
    review_id = db.Column(db.Integer, nullable=False)


    def __init__(self, r_date, r_time, r_from, r_to, v_id,r_fee, driver_id, p_id, review_id):
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
            'r_date': str(self.r_date) + " at "+ str(self.r_time.strftime("%H:%M")),
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
    u_id = db.Column(db.Integer, db.Sequence('test_id_seq'), primary_key=True)
    u_name = db.Column(db.String(80), unique=True, nullable=False)
    u_email = db.Column(db.String(120), nullable=False)
    u_password = db.Column(db.String(120), nullable=False)
    u_phone = db.Column(db.String(120), nullable=False)


    def __init__(self,  u_name, u_email,u_password,u_phone):
        self.u_name = u_name
        self.u_email = u_email
        self.u_password = u_password
        self.u_phone = u_phone

class vehicle(db.Model):
    v_id = db.Column(db.Integer, db.Sequence('veh_reg_seq'), primary_key=True, nullable=False)
    model = db.Column(db.String(80), unique=True)
    capacity = db.Column(db.Integer, nullable=False)
    license_plate = db.Column(db.String(120),unique=True, nullable=False)
    color = db.Column(db.String(120), unique=True, nullable=False)


    def __init__(self,  model, capacity,license_plate,color):
        self.model = model
        self.capacity = capacity
        self.license_plate = license_plate
        self.color = color

    def to_dict(self):
        return {
            'v_id' : self.v_id,
            'model': self.model,
            'capacity': self.capacity,
            'license_plate': self.license_plate,
            'color': self.color
        }


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

@app.route("/addpassenger", methods=['POST'])
def addpassenger():
    p_id = request.form["p_id"]
    u_id = request.form["u_id"]
    p_address = request.form["p_address"]

    entry = passenger(p_id, u_id, p_address)
    db.session.add(entry)
    db.session.commit() 
    return "Success!"

@app.route("/reviews", methods=['POST'])
def saveReviews():
    # rev_seq = Sequence('rev_id_seq') 
    # review_id = rev_seq.next_value()     ------- implemented through Model creation
    driver_review = request.form["driver_review"]
    passenger_review = request.form["passenger_review"]
    entry = reviews(driver_review, passenger_review)
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
    p_address = ''
    user_id =  session['userid']

    # ride_seq = Sequence('ride_id_seq') 
    # r_id = ride_seq.next_value()      ---- implemented through Model Creation
    radio_val = request.form["ride_type_radio"]
    r_date = request.form["r_date"]
    #db.Column(db.DateTime, default=datetime.now())
    r_time = request.form["r_time"]
    license = request.form["license_id"]

    
    r_from = request.form["r_from"]
    r_to = request.form["r_to"]
    # v_id = request.form["v_id_select"]
    auth_dict = {'data': [authorize_.to_dict() for authorize_ in authorize.query.filter_by(u_id=user_id)]}
    # ['data'][0]['v_id']
    license_ = None
    
    r_fee = request.form["r_fee"]
    review_id = None
    # print(request.form["v_id_select"])
    print(radio_val)

    if radio_val == 'Offer_Ride':
        driv_auth_dict = {'data': [d_data.to_dict() for d_data in driver.query.filter_by(u_id = user_id)]}
        if driv_auth_dict['data'] != []:
            driver_id = driv_auth_dict['data'][0]['driver_id']
            license_ = driv_auth_dict['data'][0]['license']
            
        else:
            driver_id = None
            license_ = license
        
        p_id = None
        if auth_dict['data'] != []:
            v_id = auth_dict['data'][0]['v_id']
        else:
            v_id = None


    elif radio_val == 'Request_Ride':
        v_id = None
        driver_id = None
        p_id = 2
        p_address = request.form["p_address"]
        

    entry = ride( r_date, r_time, r_from, r_to, v_id,r_fee, driver_id, p_id, review_id)
    db.session.add(entry)
    db.session.commit() 

    if radio_val == 'Offer_Ride':
        
        if driver_id == None:
            driv_var = driver(user_id, license)
            db.session.add(driv_var)
            db.session.commit()
            driver_id = driv_var.driver_id
        driv_ride_var = driver_rides(driver_id,entry.r_id)
        db.session.add(driv_ride_var)
        db.session.commit()


    elif radio_val == 'Request_Ride':
        pass_var = passenger(user_id, p_address)
        db.session.add(pass_var)
        db.session.commit()
        
        pass_ride_var = passenger_ride(pass_var.p_id,entry.r_id)
        db.session.add(pass_ride_var)
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
    # veh_seq = Sequence('test_id_seq') 
    # u_id = veh_seq.next_value()           ------ implemented through Model creation
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
    u_id = session['userid']
    # adding vehicle
    # veh_seq = Sequence('veh_reg_seq') 
    # V_ID = getVehSeq()                    -- implemented through model creation
    model = request.form["model"]
    capacity = request.form["capacity"]
    license_plate = request.form["license_plate"]
    color = request.form["color"]
    entry = vehicle(model, capacity,license_plate,color)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Vehicle added successfully"
    # linking vehicle to user
    # auth_seq = Sequence('aith_id_seq') 
    # a_id = auth_seq.next_value()      ----------- implemented through Model Creation
    auth_entry = authorize(u_id, entry.v_id)
    db.session.add(auth_entry)
    db.session.commit() 
    entry2 = driver(u_id, license_plate)
    db.session.add(entry2)
    db.session.commit() 
    return render_template('index.html', hasMessage = True, messageBody=messageBody)

@app.route("/vehicleRegister")
def vehicleRegister():
    if  session['loggedIn'] == True:
        return render_template('vehicleRegister.html')
    else:
        return render_template('login.html', hasMessage = True, messageBody="Please login to add a new Vehicle")

@app.route("/GetVehiclesList")
def GetVehiclesList():
    lis = []
    lis2 = []
    str1 = ''
    u_id = session['userid']
    auth_dict = {'data': [authorize_.to_dict() for authorize_ in authorize.query.filter_by(u_id=100)]}
    # ['data'][0]['v_id']
    print(auth_dict['data'] == [])
    return jsonify(options=str1)





@app.route("/ConnectRide", methods=['POST'])
def ConnectRide():
    p_address = ''
    user_id =  session['userid']
    ride_id_2 = request.form["ride_id_2"]
    radio_val = request.form["ride_type_radio_2"]
    driv_id = None
    pass_id = None

    if session['loggedIn'] == False:
        return render_template('login.html', hasMessage = True, messageBody="Please login to connect to a ride")

    ride_Details = ride.query.get(ride_id_2)
    
    if radio_val == 'Offer_Ride':
        driv_details = driver.query.filter_by(u_id=user_id).first()
        
        if driv_details != None:
            driv_id = driv_details.driver_id
            ride_Details.driver_id = driv_id
            driv_ride_entry = driver_rides(driv_id, ride_Details.r_id)
            db.session.add(driv_ride_entry)
             
        else:
            return render_template('vehicleRegister.html')    
    elif radio_val == 'Request_Ride':
        pass_details = passenger.query.filter_by(u_id=user_id).first()
        print(pass_details)
        if pass_details != None:
            pass_id2 = pass_details.p_id
            ride_Details.p_id = pass_id2
            pass_ride_entry = passenger_ride(pass_id2, ride_Details.r_id)
            db.session.add(pass_ride_entry)
        else:
            return render_template('addPassenger.html')    
        
    db.session.commit()
    messageBody = "Successfully added the request"
    return render_template('index.html', hasMessage = True, messageBody=messageBody)


    
@app.route("/add_passenger", methods=['POST'])
def add_passenger():
    u_id = session['userid']
    # adding vehicle
    # veh_seq = Sequence('veh_reg_seq') 
    # V_ID = getVehSeq()                    -- implemented through model creation
    addr = request.form["address"]
    entry = passenger(u_id, addr)
    db.session.add(entry)
    db.session.commit() 
    messageBody = "Passenger added successfully"

    return render_template('index.html', hasMessage = True, messageBody=messageBody)