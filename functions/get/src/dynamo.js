// Import required AWS SDK clients and commands for Node.js
const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");

// Set the AWS Region
const REGION = process.env.REGION;
// Create DynamoDB service object
const dbclient = new DynamoDBClient(REGION);

// Get single element from dynamo table
async function getElement (key) {
  const params = {
    TableName: process.env.TABLE,
    Key: {}
  }
  params.Key[`${process.env.KEY_NAME}`] = { N: key}
  const data = await dbclient.send(new GetItemCommand(params))
  return data.Item
}

modules.exports = { getElement }