var Dispatcher = require('../dispatcher/Dispatcher');

var DocumentConstants = require('../constants/DocumentConstants');

var ApiActions = {
  receiveAllDocuments: function (documents) {
    Dispatcher.dispatch({
      actionType: DocumentConstants.DOCUMENTS_RECEIVED,
      documents: documents
    });
  }
};

module.exports = ApiActions;
