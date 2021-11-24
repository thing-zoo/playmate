import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore
import xml_parsing

cred = credentials.Certificate('lib/firebase_design/myKeys.json')
firebase_admin.initialize_app(cred,
{
    'databaseURL' : 'https://playmate-b7739.firebaseio.com'
})

db = firestore.client()

docs = db.collection('location').stream()
count =0
location = {}
for doc in docs:
    tempDict = doc.to_dict()
    print(tempDict['area'])

