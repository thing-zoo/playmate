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

locationDic = xml_parsing.getLocationDic()
for doc_location in locationDic.keys(): 
    ref = db.collection('location').document(doc_location)
    ref.set(locationDic[doc_location])             

