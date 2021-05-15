from pathlib import Path
import urllib.request
import zipfile
import sys
import os

def data_download(title):
  url = "https://api.odpt.org/api/v4/files/Toei/data/ToeiBus-GTFS.zip?acl:consumerKey=" + os.environ['token']
  urllib.request.urlretrieve(url,"{0}".format(title+'.zip'))
  print("\n=ダウンロード完了\n")

def data_unzip(title):
  with zipfile.ZipFile(title+'.zip') as myzip:
    myzip.extractall("./ToeiBus-GTFS")
    myzip.printdir()
  print("\n=解凍完了\n")

def data_convert(title):
  for f in Path('.').rglob(title+'/*.txt'):
    f.rename('./'+title+'/'+f.stem+'.csv')
    print('変換完了(txt -> csv)：'+f.stem+'.csv')
  print("\n=全ファイル変換完了\n")

def data_upload(title):
  print("DBアップロード 実装予定")
  # print("\n=アップロード完了\n")


def main():
  print("【設定開始】")
  title = "ToeiBus-GTFS"
  select = input("【 1：フルセットアップ, 2：データダウンロードのみ, 3：データアップロード 】\n  > ")
  if select in ["1","2","3"]:
    if select != "3":
      data_download(title)
      data_unzip(title)
    if select != "2":
      data_convert(title)
      data_upload(title)
    print("【設定完了】")
  else:
    print("\n異常な入力です。")




if __name__ == '__main__':
  main()
