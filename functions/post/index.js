const getFromDB = require('./src/dynamo')

exports.handler = async (event, context, callback) => {
  let key = event.queryStringParameters.key

  let element = await getFromDB.getElement(key)

  // TODO implement
  const response = {
      statusCode: 200,
      body: JSON.stringify(element),
  };
  callback(null, response)
};
