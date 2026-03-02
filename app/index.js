
var playersName = prompt("Please enter two names, separated by a comma:");
var names = playersName.split(',');

// Trim names to remove any accidental spaces
var firstName = names[0].trim();
var secondName = names[1].trim();

document.getElementById("player1").textContent = firstName + " ";
document.getElementById("player2").textContent = secondName + " ";


var previousC = null; 
var count = 0;
var score1 = 0;
var score2 = 0;
var turn = 1;


function setupGame() {

  var numCards = document.querySelectorAll(".card").length;
  var cards = document.querySelectorAll(".card");
  var twice = new Array(17).fill(0);


  //front
  for (let i = 0; i < numCards; i++) {
    cards[i].classList.add("front");
  }


  //back
  for (let i = 0; i < numCards; i++) {
    var randomNumber;

    do {
      randomNumber = Math.floor(Math.random() * 16) + 1;
    } while (twice[randomNumber] === 2);
      
    twice[randomNumber]+=1;

    var randomImageSource = "assests/" + randomNumber + ".jpg";
    var img = document.createElement("img");
    img.setAttribute("src", randomImageSource);

    cards[i].appendChild(img);
  }


  for (let i = 0; i < numCards; i++) {
    document.querySelectorAll(".card")[i].addEventListener("click", function () {

      var currentC = this;

      // Check if previousC is not null and is different from currentC
      if (previousC === null) {
        previousC = currentC;
      }

      clicked(currentC);
      count++;

      // Update previousC to the current card
      if(count === 2){

        playersTurn(previousC,currentC);

        // check(previousC,currentC);
        previousC = null;
        count = 0;
      }

    });
  }
}


function playersTurn(previous,current) {

  if (turn==1) {

    check(previous,current,1);
    turn=2;

  } else if (turn==2) {
    check(previous,current,2);
    turn=1;

  }
 
}


function clicked(currentKey){

  currentKey.classList.add("pressed");
  setTimeout(function(){
    currentKey.classList.remove("pressed");
  },100);

  setTimeout(function(){
    currentKey.classList.remove("front");
  },375);

  setTimeout(function(){
    currentKey.classList.add("flipped");
  },100);

} 


function check(c1,c2,pNum) {
  var card1 = c1.querySelector("img").getAttribute("src");
  var card2 = c2.querySelector("img").getAttribute("src");

  function flipBack() {
    return new Promise(resolve => {
        setTimeout(function() {
            c1.classList.remove("flipped");
            c1.classList.add("front");
            c2.classList.remove("flipped");
            c2.classList.add("front");
            resolve();
        }, 1000);
    });
  }


  if (card1 === card2 && c1.id !== c2.id) {
    if (pNum==1){
     score1++;
     document.getElementById("score" + pNum).textContent = score1;

    }else if (pNum==2) {
     score2++;
     document.getElementById("score" + pNum).textContent = score2;
    }

  }else{
     flipBack().then(() => {
            console.log("Cards flipped back over");
        });
  }
}


setupGame();


// Reset button
document.getElementById('restartButton').addEventListener('click', function() {

  score1 = 0;
  score2 = 0;
  document.getElementById("score" + 1).textContent = score1;
  document.getElementById("score" + 2).textContent = score2;


  // Remove existing cards children (images)
  var cards = document.querySelectorAll(".card");
  cards.forEach(card => {
      while (card.firstChild) {
          card.removeChild(card.firstChild);
      }
      card.classList.remove("flipped", "front", "pressed"); 
      var cardClone = card.cloneNode(true); // true means it clones children as well
      card.parentNode.replaceChild(cardClone, card);
  });
  
  setupGame();  
});
