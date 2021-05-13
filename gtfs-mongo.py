from pymongo import MongoClient
import gtfs_rt_pb2
import requests
import datetime
import time
import os

class TestMongo(object):

    def __init__(self):
        self.client = MongoClient('mongo',27017,username='root',password='root')
        self.db = self.client['gtfs']

    def add_one(self,json):
        return self.db.gtfs.insert_one(json)

def gtfs(mongo):
  url = "https://api.odpt.org/api/v4/gtfs/realtime/ToeiBus?acl:consumerKey=" + os.environ['token']
  response = requests.get(url)
  feed = gtfs_rt_pb2.FeedMessage()
  feed.ParseFromString(response.content)
  for entity in feed.entity:
    post = {
      "id": entity.id,
      "time": datetime.datetime.fromtimestamp(entity.vehicle.timestamp),
      "current_stop_sequence": entity.vehicle.current_stop_sequence,
      "trip_id": entity.vehicle.trip.trip_id,
      "stop_id": entity.vehicle.stop_id,
      "vehicle": {
        "trip": {
          "trip_id": entity.vehicle.trip.trip_id,
          "schedule_relationship": entity.vehicle.trip.schedule_relationship,
          "route_id": entity.vehicle.trip.route_id
        },
        "position":{
          "latitude": entity.vehicle.position.latitude,
          "longitude": entity.vehicle.position.longitude
        },
        "current_stop_sequence": entity.vehicle.current_stop_sequence,
        "timestamp": entity.vehicle.timestamp,
        "stop_id": entity.vehicle.stop_id,
        "vehicle": {
          "id": entity.vehicle.vehicle.id,
          "label": entity.vehicle.vehicle.label
        }
      }
    }
    mongo.add_one(post)


def main():
  mongo = TestMongo()
  for value in range(10):
    print("開始時間:"+str(datetime.datetime.now())+"__"+str(value+1)+"回目")
    gtfs(mongo)
    time.sleep(60)


if __name__ == '__main__':
  main()
