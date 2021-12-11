import googlemaps

def getGeocode(addr, gmaps):
    # Geocoding an address
    geocode_result = gmaps.geocode(addr)
    print(len(geocode_result))
    if len(geocode_result) != 0:
        lat = geocode_result[0]['geometry']['location']['lat']
        lng = geocode_result[0]['geometry']['location']['lng']
        return (lat, lng)
    return (0,0)


def getGmaps():
    return googlemaps.Client(key='AIzaSyBUttT--g3hJZ8wlaGdzyFx-nney2wIltE')