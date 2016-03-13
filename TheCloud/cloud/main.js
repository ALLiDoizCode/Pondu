
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("PushComment", function(request, response) {
   
  var theChannel = request.params.channel
  var theType = request.params.theType
  var msg = "msg"
  var theAlert = "New Comment"

  if (theType == msg) {

      theAlert = "New Message"
  }
 
  Parse.Push.send({
            channels: [ theChannel ],
            data: {
            alert: theAlert ,
            }}, {
                success: function() {
                response.success();
   },
   error: function(error) {
       response.error(error);   
   }
});
 
});
