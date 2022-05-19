import json
import os

def lambda_handler(event, context):
   try:
      body = event['body']
      string_txt = json.dumps(body)
      print(string_txt)
      # Read the replacer words from env variables
      replacer_words = os.environ["replacer_words"].split(",")
      #convert input string into an array of words
      string_txt_array=string_txt.replace("\"","").split()
      print(string_txt_array)
      #loop through both the array and replace if string words match with replacer words
      for word in replacer_words:
         print(word)
         for i in range(len(string_txt_array)):
            #print(txt)
            if(string_txt_array[i]==word):
               string_txt_array[i]=string_txt_array[i]+"©"
      
      print(string_txt_array)   
      #reconstruct the string back from the array
      string_txt=" "
      string_txt = ' '.join([str(elem) for elem in string_txt_array])
       
      print(string_txt)
      return {
         'statusCode': 200,
         'body': json.loads(str("\""+string_txt+"\""))
      }
   except Exception as e:
      print ("An error occurred - " + str(e))
      return{
         'statuscode': 500,
         'body': 'Internal Server Error'
      }
