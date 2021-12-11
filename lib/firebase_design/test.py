import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore
import requests, bs4
import pandas as pd
from lxml import html
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus, unquote
import firebase_process


cred = credentials.Certificate('lib/firebase_design/firebaseKeys.json')
firebase_admin.initialize_app(cred,
{
    'databaseURL' : 'https://playmate-b7739.firebaseio.com'
})
db = firestore.client()
ref = db.collection('test').document('대구 남구')
print(ref.get(field_paths={'hzzzz'}).to_dict().get('hzzzz'))


