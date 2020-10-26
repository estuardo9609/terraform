// Import required AWS SDK clients and commands for Node.js
const AWS = require("aws-sdk");

AWS.config.update({region: process.env.REGION});

// Create DynamoDB service object
const dbclient = new AWS.DynamoDB.DocumentClient({apiVersion: '2012-08-10'});

// Get single element from dynamo table
async function getElement (key) {
  const params = {
    TableName: process.env.TABLE,
    Key: {}
  }
  params.Key[`${process.env.KEY_NAME}`] = key
  dbclient.get(params, (err, data) => {
    if (err) {
      console.log(err)
      return Promise.reject(err)
    } else{
      return Promise.resolve(data.Item)
    }
  })
}

module.exports = { getElement }