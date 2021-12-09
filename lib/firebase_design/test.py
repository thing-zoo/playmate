import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore
import requests, bs4
import pandas as pd
from lxml import html
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus, unquote
# cred = credentials.Certificate('lib/firebase_design/myKeys.json')
# firebase_admin.initialize_app(cred,
# {
#     'databaseURL' : 'https://playmate-b7739.firebaseio.com'
# })
# db = firestore.client()

keys = ['능금어린이공원 어린이놀이시설']
detailDict = {'능금어린이공원 어린이놀이시설' : {}}
My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')
xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltUtensilInfoService/getFcltUtensilInfo'
for ciName in keys:
    queryParams = '?' + urlencode(     
        {
            quote_plus('ServiceKey') : My_API_Key,
            quote_plus('ciName') : ciName       
        }
    )
    response = requests.get(xmlUrl + queryParams).text.encode('utf-8')
    xmlobj = bs4.BeautifulSoup(response, 'lxml-xml')
    rows = xmlobj.findAll('item')
    implement = []
    implement_code = []
    for col in rows:
        if col.find('code5') is not None:
            implement_code.append(col.find('code5').text)
        if col.find('name5') is not None:
            implement.append(col.find('name5').text)
    detailDict[ciName]['implement'] = implement    
    detailDict[ciName]['implement_code'] = implement_code
    print(detailDict[ciName])
