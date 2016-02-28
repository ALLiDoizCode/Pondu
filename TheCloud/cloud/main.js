
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("PushComment", function(request, response) {
  
  var theChannel = request.params.channel

  Parse.Push.send({
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
});

});
