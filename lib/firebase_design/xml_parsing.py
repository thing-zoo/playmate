import requests, bs4
import pandas as pd
from lxml import html
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus, unquote

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore


def getTotalCount(xmlUrl, My_API_Key, queryParams):

    response = requests.get(xmlUrl + queryParams).text.encode('utf-8')
    xmlobj = bs4.BeautifulSoup(response, 'lxml-xml')
    rows = xmlobj.findAll('totalCount')
    return int(rows[0].text)

def getLocationDic():
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltUtensilInfoService/getFcltUtensilInfo'
    My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')    # 아래 내가 받은 인증키가 안 되서 수업용 인증키 사용.
    pageNo= 1
    areaNm = '대구'
    dic = {}
    queryParams = '?' + urlencode(    
            {
                quote_plus('ServiceKey') : My_API_Key,
                quote_plus('pageNo') : pageNo,
                quote_plus('areaNm') : areaNm       
            }
        )
    totalCount = getTotalCount(xmlUrl, My_API_Key, queryParams)
    pageEnd = totalCount//10 + 1
    if totalCount%10 == 0:
        pageEnd -= 1

    while pageNo <= pageEnd:
        queryParams = '?' + urlencode(    
            {
                quote_plus('ServiceKey') : My_API_Key,
                quote_plus('pageNo') : pageNo,
                quote_plus('areaNm') : areaNm       
            }
        )
        response = requests.get(xmlUrl + queryParams).text.encode('utf-8')
        xmlobj = bs4.BeautifulSoup(response, 'lxml-xml')
        rows = xmlobj.findAll('item')
        for col in rows:
            name3 = col.find('name3').text
            ciName = col.find('ciName').text
            if '삭제' in ciName:
                continue
            ciSeq = col.find('ciSeq').text
            if not ciName in dic:
                dic[ciName] = {
                    'ciName' : ciName, 
                    'ciSeq':ciSeq, 
                    'area': name3,
                }
        pageNo += 1
        if(pageNo%50==0):
            print(pageNo, end=' ')

    #놀이 시설 정보 서비스 ciSeq -> name3
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltInfoService/getFcltInfo'
    My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')    # 아래 내가 받은 인증키가 안 되서 수업용 인증키 사용.

    keys = dic.keys()
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
        for col in rows:
            addr = ''
            if col.find('ciRaddr2') is not None:
                addr = col.find('ciRaddr2').text
            elif col.find('ciRaddr1') is not None:
                addr = col.find('ciRaddr1').text
            elif col.find('ciNaddr2') is not None:
                addr = col.find('ciNaddr2').text
            elif col.find('ciNaddr1') is not None:
                addr = col.find('ciNaddr1').text    
            code1 = col.find('code1').text
            dic[ciName]['addr'] = addr
            dic[ciName]['category']= code1
    print('success to get location dictionary from api')
    return dic

def getDetailDic():


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

    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltUtensilInfoService/getFcltUtensilInfo'
    My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')    # 아래 내가 받은 인증키가 안 되서 수업용 인증키 사용.
    pageNo= 1
    areaNm = '대구'
    dic = {}
    queryParams = '?' + urlencode(    
            {
                quote_plus('ServiceKey') : My_API_Key,
                quote_plus('pageNo') : pageNo,
                quote_plus('areaNm') : areaNm       
            }
        )
    totalCount = getTotalCount(xmlUrl, My_API_Key, queryParams)
    pageEnd = totalCount//10 + 1
    if totalCount%10 == 0:
        pageEnd -= 1

    while pageNo <= pageEnd:
        queryParams = '?' + urlencode(    
            {
                quote_plus('ServiceKey') : My_API_Key,
                quote_plus('pageNo') : pageNo,
                quote_plus('areaNm') : areaNm       
            }
        )
        response = requests.get(xmlUrl + queryParams).text.encode('utf-8')
        xmlobj = bs4.BeautifulSoup(response, 'lxml-xml')
        rows = xmlobj.findAll('item')
        for col in rows:
            name3 = col.find('name3').text
            ciName = col.find('ciName').text
            if '삭제' in ciName:
                continue
            ciSeq = col.find('ciSeq').text
            if not ciName in dic:
                dic[ciName] = {
                    'ciName' : ciName, 
                    'ciSeq':ciSeq, 
                    'area': name3,
                }
        pageNo += 1
        if(pageNo%50==0):
            print(pageNo, end=' ')

    #놀이 시설 정보 서비스 ciName -> name3
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltInfoService/getFcltInfo'
    My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')    # 아래 내가 받은 인증키가 안 되서 수업용 인증키 사용.

    keys = dic.keys()
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
        for col in rows:
            addr = ''
            if col.find('ciRaddr2') is not None:
                addr = col.find('ciRaddr2').text
            elif col.find('ciRaddr1') is not None:
                addr = col.find('ciRaddr1').text
            elif col.find('ciNaddr2') is not None:
                addr = col.find('ciNaddr2').text
            elif col.find('ciNaddr1') is not None:
                addr = col.find('ciNaddr1').text    
            code1 = col.find('code1').text
            dic[ciName]['addr'] = addr
            dic[ciName]['category']= code1
    print('success to get location dictionary from api')
    return dic

    

