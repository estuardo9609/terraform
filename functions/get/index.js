const getFromDB = require('./src/dynamo')

exports.handler = async (event) => {
  let key = event.pathParameters.key

  let element = getFromDB.getElement(key)
  // TODO implement
  const response = {
      statusCode: 200,
      body: JSON.stringify(element),
  };
  return response;
};
