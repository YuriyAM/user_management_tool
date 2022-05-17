import os
from pymongo import MongoClient
from models.credentials import Credentials
from models.user import User

from providers.dotenv_provider import CONFIG, ROOT_DIR


def connect():
    cs = f"mongodb://{CONFIG['MONGO_USER']}:{CONFIG['MONGO_PASSWORD']}@{CONFIG['MONGO_HOST']}:{CONFIG['MONGO_PORT']}"
    return MongoClient(cs)[CONFIG["MONGO_DATABASE"]]


def get_users():
    db = connect()
    users = db['users'].find()
    if (users != None):
        users = [User.fromJson(u) for u in users]
    return users


def find_user(username):
    assert isinstance(username, str), 'Argument of wrong type!'
    db = connect()
    user = db['users'].find_one({"username": username})
    if (user != None):
        user = User.fromJson(user)
    return user


def insert_user(user):
    assert isinstance(user, User), 'Argument of wrong type!'
    db = connect()
    return db['users'].insert_one(User.__dict__)


def delete_user(user):
    assert isinstance(user, User), 'Argument of wrong type!'
    db = connect()
    return db['users'].delete_one({'username': user.username})


def check_credentials(creds):
    assert isinstance(creds, Credentials), 'Argument of wrong type!'
    db = connect()
    user = db['users'].find_one({
        'username': creds.username,
        'password': creds.password
    })
    if (user != None):
        user = User.fromJson(user)
    return user


def init():
    if (not find_user("admin")):
        admin = User("admin", privivileged=True)
        insert_user(admin)
    else:
        print("Database already initialized")
