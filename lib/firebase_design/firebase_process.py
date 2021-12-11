import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore
import xml_parsing
import conversing_address

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
    gmaps = conversing_address.getGmaps()
    for doc in docs:
        tempDict = doc.to_dict()
        area = tempDict['area']
        if area not in areaDict:
            areaDict[area] = []
        else:     
            if 'addr' in tempDict:
                addr = tempDict['addr']
                curDict = {}
                curDict['ciName'] = tempDict['ciName']
                curDict['category'] = tempDict['category']
                lat, lng =  conversing_address.getGeocode(addr,gmaps)
                if lat == 0:
                    continue
                curDict['lat'] = lat
                curDict['lng'] = lng  
                areaDict[area].append(curDict)

    for doc in areaDict.keys(): 
        ref = db.collection('areaToaNme').document(doc)
        ref.set({'playground':areaDict[doc]})

def getFirestoreClient():
    cred = credentials.Certificate('lib/firebase_design/firebaseKeys.json')
    firebase_admin.initialize_app(cred,
    {
        'databaseURL' : 'https://playmate-b7739.firebaseio.com'
    })
    return firestore.client()



#db = getFirestoreClient()
#makeAreaToNameTable(db)
#배열이안들어가네 


