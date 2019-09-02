import boto3
import logging
import os
import time
import json

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)





def close(session_attributes, fulfillment_state, message):
    response = {
        'sessionAttributes': session_attributes,
        'dialogAction': {
            'type': 'Close',
            'fulfillmentState': fulfillment_state,
            'message': message
        }
    }
    return response
 
 
def start_ec2(intent_request):
	card_title = "Starting"
	
	slots = intent_request['currentIntent']['slots']
	instance_value = intent_request['currentIntent']['slots']['Instance']
	instanceValue = instance_value
	ec2 = boto3.client('ec2',region_name='us-east-1')
	response = ec2.describe_instances()
	output_session_attributes = {}
	insId = []
	for reservation in response["Reservations"]:
		for instance in reservation["Instances"]:
			for i in instance["Tags"]:
				if(i["Value"]==instanceValue):
					print("instance is " + instance["InstanceId"])
					rinstance = instance["InstanceId"]
					insId.append(instance["InstanceId"])
	print(insId)
	ec2.start_instances(InstanceIds=insId)
	
	return close(
		output_session_attributes,
        'Fulfilled',
        {
            'contentType': 'PlainText',
            'content': 'Instance have been started.'
        }
    )

def stop_ec2(intent_request):
	card_title = "Starting"
	
	slots = intent_request['currentIntent']['slots']
	instance_value = intent_request['currentIntent']['slots']['Server']
	instanceValue = instance_value
	ec2 = boto3.client('ec2',region_name='us-east-1')
	response = ec2.describe_instances()
	output_session_attributes = {}
	insId = []
	for reservation in response["Reservations"]:
		for instance in reservation["Instances"]:
			for i in instance["Tags"]:
				if(i["Value"]==instanceValue):
					print("instance is " + instance["InstanceId"])
					rinstance = instance["InstanceId"]
					insId.append(instance["InstanceId"])
	print(insId)
	ec2.stop_instances(InstanceIds=insId)
	
	return close(
		output_session_attributes,
        'Fulfilled',
        {
            'contentType': 'PlainText',
            'content': 'Instance have been stopped.'
        }
    )

# --- Intents ---

def dispatch(intent_request):
    """
    Called when the user specifies an intent for this bot.
    """

    logger.debug('dispatch userId={}, intentName={}'.format(intent_request['userId'], intent_request['currentIntent']['name']))

    intent_name = intent_request['currentIntent']['name']

    # Dispatch to your bot's intent handlers
    if intent_name == 'StartServer':
        return start_ec2(intent_request)
    elif intent_name == 'StopServer':
        return stop_ec2(intent_request)

    raise Exception('Intent with name ' + intent_name + ' not supported')

""" --- Main Handler --- """

def lambda_handler(event, context):

	os.environ['TZ'] = 'America/New_York'
	time.tzset()
	logger.debug('event.bot.name={}'.format(event['bot']['name']))

	return dispatch(event)
