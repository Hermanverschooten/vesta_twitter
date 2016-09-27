import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})
let tweets = $("#tweets");

socket.connect()

let channel = socket.channel("tweets:lobby", {});

channel.join()
.receive("ok", data => {
  console.log("Joined");
})
.receive("error", data  => {
  console.log("Unable to join");
})

channel.on("tweet", tweet => {
  console.log(tweet);
  // var username = tweet.user.name || "anonymous";
  // var body     = tweet.text;

  // $tweets.prepend(`<blockquote class='twitter-tweet'>${username}<p>${body}</p></blockquote>`);
})

export default socket;
