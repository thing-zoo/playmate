from firebase_admin import firestore
import requests, bs4
import pandas as pd
from lxml import html
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus, unquote

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db


def getTotalCount(xmlUrl, My_API_Key, queryParams):

    response = requests.get(xmlUrl + queryParams).text.encode('utf-8')
    xmlobj = bs4.BeautifulSoup(response, 'lxml-xml')
    rows = xmlobj.findAll('totalCount')
    return int(rows[0].text)

def getLocationDict():
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

def getDetailDict(db):

    detailDict = {} #key : ciName 
    docs = db.collection('location').stream()
    for doc in docs:
        tempDict = doc.to_dict()
        ciName = tempDict['ciName']
        detailDict[ciName] = {
            'ciName': tempDict['ciName'],
            'area': tempDict['area'],
            'ciSeq': tempDict['ciSeq'],
        }
        if 'category' in tempDict.keys():
            detailDict[ciName]['category'] = tempDict['category']
        if 'addr' in tempDict.keys():
            detailDict[ciName]['addr'] = tempDict['addr']    
        

    #전국어린이 놀이시설 정보 서비스
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltInfoService/getFcltInfo'
    My_API_Key = unquote('gHibR78%2FzKSyCv%2B4Pri85%2FvdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ%3D%3D')    # 아래 내가 받은 인증키가 안 되서 수업용 인증키 사용.

    keys = detailDict.keys()
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
            if col.find('ciInstall') is not None:
                ciInstall = col.find('ciInstall').text
                detailDict[ciName]['ciInstall'] = ciInstall
            if col.find('ciBest') is not None:
                ciBest = col.find('ciBest').text
                detailDict[ciName]['ciBest'] = ciBest

    #안전 
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltSafeInspctInfoService/getFcltSafeInspctInfo'
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
            if col.find('ctmTestDate') is not None:
                ctmTestDate = col.find('ctmTestDate').text
                detailDict[ciName]['ctmTestDate'] = ctmTestDate

    #보험정보
    xmlUrl = 'http://openapi.cpf.go.kr/openapi/service/rest/ChildPlyFcltInsrncSbscrbInfoService/getInsrncSbscrbInfo'
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
            if col.find('cieSeq') is not None:
                cieSeq = col.find('cieSeq').text
                print(ciName, cieSeq)
                detailDict[ciName]['cieSeq'] = cieSeq
      
    #기구정보
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

    print('success to get dictionary from api')
    return detailDict
