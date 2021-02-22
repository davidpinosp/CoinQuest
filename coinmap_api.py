

import requests
def get_locations(minlat,maxlat,minlon,maxlon):
    lat1 =minlat
    lat2 = maxlat
    lon1= minlon
    lon2 = maxlon
    link = requests.get(f"https://coinmap.org/api/v1/venues/?lat1={lat1}&lat2={lat2}&lon1={lon1}&lon2={lon2}").json()
    arr = link["venues"]
    for i in arr:
        print(i["id"],i["lat"],i["lon"],i["category"])

get_locations(30,38,120,123)
