import json


def lambda_handler(event, context):
   try:
      body = event['body']
      string_txt = json.dumps(body)
      result = str(string_txt.replace("Amazon", "Amazon©").replace("Google", "Google©").replace("Microsoft", "Microsoft©").replace("Oracle", "Oracle©").replace("Deloitte", "Deloitte©"))
      print(result)
      return {
         'statusCode': 200,
         'body': json.loads(result)
      }
   except Exception as e:
      print ("An error occurred - " + str(e))
      return{
         'statuscode': 500,
         'body': 'Internal Server Error'
      }
