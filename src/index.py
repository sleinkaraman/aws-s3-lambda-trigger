import json
import urllib.parse

def handler(event, context):
    try:
        bucket = event['Records'][0]['s3']['bucket']['name']
        key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
        
        print(f"File uploaded! Bucket: {bucket}, Key: {key}")
        
        return {
            'statusCode': 200,
            'body': json.dumps(f"Successfully processed {key} from {bucket}")
        }
    except Exception as e:
        print(f"Error: {str(e)}")
        raise e