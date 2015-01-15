var image_token = "48d2fc2358a74103eddcfc91ce56b845704aa557d6cfd12d83a064ba315118e982f4ca049b1ad309176d5593475b06ac6c1736bfa609349c981cb29687ad44e0"

var canvas;
var ctx;
var photos = new Array();
var wss = "ws://localhost:8080";
var ws;
$(document).ready(function(){
  $("#btn").click(function(){
    getPictures();
  });
  ws = new WebSocket(wss,"image-protocol");
  ws.addEventListener("open",wsOpen);
  ws.addEventListener("message",wsMessage);
  canvas = document.getElementById("canvas");
  canvas.width = 1000;
  canvas.height = window.innerHeight;
  ctx = canvas.getContext("2d");
});
function wsOpen(){
  console.log("socket server opened")
}
function wsMessage(message){
  console.log(message.data);
  if(message.data == "update pof"){
    getPictures();
  }
}
function getPictures(){
  $.ajax({
    type:"GET",
    url: "/process/get_pictures",
    crossDomain: true,
    data: {post_token: image_token},
    success: function(data){
      if(typeof data == 'object')
        updateCanvas(data);
      else{
        console.log(typeof data);
        alert(data);
      }
    },
    error: function(err){
      console.log(err);
    }
  });
}
function updateCanvas(photos){
  var photoSize = 200;
  var counter = 0;
  canvas.width = photos.length*photoSize + photoSize;
  for(var i in photos){
    var img = new Image();
    img.onload = function(){
      counter ++;
      var scale = this.height/ this.width;
      ctx.drawImage(this,counter*photoSize,photoSize+canvas.height-200-photoSize*scale,photoSize,photoSize*scale);
    };
    img.src= photos[i];
  }
}
