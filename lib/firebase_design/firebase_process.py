import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore
import xml_parsing



def makeDetailTable(db):
    detailDict = xml_parsing.getDetailDict(db)
    for doc_detail in detailDict.keys(): 
        ref = db.collection('detail').document(doc_detail)
        ref.set(detailDict[doc_detail])             

def makeLocationTable(db):
    locationDict = xml_parsing.getLocationDict()
    for doc_location in locationDict.keys(): 
        ref = db.collection('location').document(doc_location)
        ref.set(locationDict[doc_location])             

def makeAreaToNameTable(db):
    docs = db.collection('location').stream()
    #ciNames= []
    #ciSeqs = []
    areaDict = {}
    for doc in docs:
        tempDict = doc.to_dict()
        area = tempDict['area']
        if area not in areaDict:
            areaDict[area] = {
                'ciNames' : [],
                'ciSeqs' : []
            }
        else:
            ciName = tempDict['ciName']
            ciSeq = tempDict['ciSeq']
            areaDict[area]['ciNames'].append(ciName)
            areaDict[area]['ciSeqs'].append(ciSeq)        
    
    for doc in areaDict.keys(): 
        ref = db.collection('areaToName').document(doc)
        ref.set(areaDict[doc])
        print(doc, areaDict[doc])


def getFirestoreClient():
    cred = credentials.Certificate('lib/firebase_design/myKeys.json')
    firebase_admin.initialize_app(cred,
    {
        'databaseURL' : 'https://playmate-b7739.firebaseio.com'
    })
    return firestore.client()

db = getFirestoreClient()
makeDetailTable(db)
#배열이안들어가네 
