// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

let lati= document.getElementById('userId1')
let longi= document.getElementById('userId2')


// Gmap

var locations= [[lati,longi]]

function initMap() {
  // The location of Uluru
  // console.log()
  // console.log()
  let lati1= document.getElementById('restId1')
  let long2= document.getElementById('restId2')
  const uluru = {lat: parseFloat(lati1.textContent), lng: parseFloat(long2.textContent)};
  console.log(lati1.textContent)
  // const uluru2 = { lat: , lng: 88.3744314 };
  // The map, centered at Uluru
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: uluru,
  });
  // The marker, positioned at Uluru
  const marker = new google.maps.Marker({
    position: uluru,
    map: map,
  });

}

window.initMap = initMap;

// 22.701429
// 88.3744314


// Checkboxes 

var checkboxes= document.getElementsByClassName("checkboxes")



for(let i=0; i<checkboxes.length;i++)
{
console.log("Hi")
}

