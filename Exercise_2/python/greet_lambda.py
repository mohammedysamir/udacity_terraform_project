import os

def lambda_handler(event, context):
    print("Received event: " + str(event))
    return "{} from Lambda!".format(os.environ['greeting'])
