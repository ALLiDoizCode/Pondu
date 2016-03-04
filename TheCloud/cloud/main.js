
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("PushComment", function(request, response) {

	var message = "Msg"
  
  var theChannel = request.params.channel
  var theType = request.params.theType

  Parse.Push.send({

  	if theType == message {
  	
  		channels: [ theChannel ],
            data: {
            alert: "New Message" ,
            }}, {
                success: function() {
                response.success();
   },
   error: function(error) {
       response.error(error);   

   }else{

   	channels: [ theChannel ],
            data: {
            alert: "New Comment" ,
            }}, {
                success: function() {
                response.success();
   },
   error: function(error) {
       response.error(error);   
   }

   }

  }
            
});

});
