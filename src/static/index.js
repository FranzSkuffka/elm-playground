// pull in desired CSS/SASS files

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );
var _ = require('lodash/fp')

// Initialize Firebase
// TODO: Replace with your project's customized code snippet
var config = {
  apiKey: "AIzaSyBDSVVnoa0NZXhYZAIk9RfwZPny6ZzRqfg",
  authDomain: "plza-b41e3.firebaseapp.com",
  databaseURL: "https://plza-b41e3.firebaseio.com"
};
firebase.initializeApp(config);
var database = firebase.database();




app.ports.create.subscribe( str => {
  var item = createItem({title: str})
  app.ports.suggestions.send([`SAVED ${item.key}`])
})

const items = database.ref('items')

val = ref => ref.val()
const passItemsToElm = _.flow([
  val,
  _.toPairs,
  _.map( (keyValuePair) => _.set('key')(keyValuePair[0])(keyValuePair[1])),
  // console.log.bind(console),
  app.ports.items.send
])
items.on('value', passItemsToElm)

function createItem(item) {
  var {title, description, type} = item
  return firebase.database().ref('items').push({
    user: 'someUser',
    title: title,
    description: 'someDescription',
    type: 'offer'
  });
}
