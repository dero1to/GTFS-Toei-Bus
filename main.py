import gtfs_rt_pb2
import requests
import os

url = "https://api.odpt.org/api/v4/gtfs/realtime/ToeiBus?acl:consumerKey=" + os.environ['token']

feed = gtfs_rt_pb2.FeedMessage()
response = requests.get(url)
feed.ParseFromString(response.content)
for entity in feed.entity:
  print(entity)
