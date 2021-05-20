from pymongo import MongoClient
import gtfs_rt_pb2
import requests
import datetime
import time
import os

class MongoTools(object):

  def __init__(self, database, schema):
    self.client = MongoClient('mongo',27017,username='root',password='root')
    self.db = self.client[database]
    self.collection = self.db.get_collection(schema)

  def add_one(self, json):
    return self.collection.insert_one(json)

  def find_one(self, projection=None,filter=None, sort=None):
    return self.collection.find_one(projection=projection, filter=filter, sort=sort)

  def find(self, projection=None,filter=None, sort=None):
    return  self.collection.find(projection=projection, filter=filter, sort=sort)

  def update_one(self, filter, update):
    return self.collection.update_one(filter, update)

  def update_many(self, filter, update):
    return self.collection.update_many(filter, update)

  def replace_one(self, filter, replacement):
    return self.collection.replace_one(filter, replacement)

  def find_one_and_update(self, filter, update):
    return self.collection.find_one_and_update(filter, update)

  def find_one_and_replace(self, filter, replacement):
    return self.collection.find_one_and_replace(filter, replacement)

  def count_documents(self, json):
    return self.collection.count_documents(json)

def toei_bus():
  url = "https://api.odpt.org/api/v4/gtfs/realtime/ToeiBus?acl:consumerKey=" + os.environ['token']
  response = requests.get(url)
  feed = gtfs_rt_pb2.FeedMessage()
  feed.ParseFromString(response.content)
  return feed

def create_json(entity):

  data = {
    "id": entity.id,
    "update_at": datetime.datetime.now(),
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
  return data


def gtfs(mongo, mongo2):

  feed = toei_bus()
  print(len(feed.entity))
  for entity in feed.entity:
    data = create_json(entity)
    if mongo.count_documents({'id': data['id']}):
      if mongo.count_documents({'id': data['id'], 'current_stop_sequence': data['current_stop_sequence']}) != '0':
        mongo.update_one({'id': data['id']}, {'$set': data})
        mongo2.add_one(data)
    else:
      mongo.add_one(data)
      mongo2.add_one(data)


def main():

  mongo = MongoTools('gtfs', 'gtfs')
  mongo2 = MongoTools('gtfs', 'gtfs_bk')
  for value in range(1000):
    print("開始時間:"+str(datetime.datetime.now())+"__"+str(value+1)+"回目")
    gtfs(mongo,mongo2)
    time.sleep(60)

if __name__ == '__main__':
  main()
