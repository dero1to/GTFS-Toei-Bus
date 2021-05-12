from pymongo import MongoClient
from datetime import datetime

class TestMongo(object):
    
    def __init__(self):
        self.client = MongoClient()
        self.db = self.client['test']

    def add_one(self):
        post = {
            'title': 'ハリネズミ',
            'content': 'ハリネズミ可愛い~',
            'created_at': datetime.now()
        }
        return self.db.test.insert_one(post)

def main():
    obj = TestMongo()
    rest = obj.add_one()
    print(rest)

if __name__ == '__main__':
    main()