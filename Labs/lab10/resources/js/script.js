//helper functions
var dayOfWeek = "";
function formatDate(date, month, year)
{
  month = (month.length < 2) ? ('0' + month) : month;
  date = (date.length < 2)? ('0' + date) : date;
  return [year,month,date].join('-');
}
function getDayofWeek(date, month, year){
  var week_names = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  dayOfWeek =  week_names[new Date([month,date,year].join('-')).getDay()];
  return dayOfWeek; 
}
function getFarenheitTemp(temp){
  return (9*temp/5)+32;
}

//run when the document object model is ready for javascript code to execute
$(document).ready(function() {
  var latitude = 40;
  var longitude = -105;
  var url ='https://api.weatherstack.com/forecast?access_key=5bc82451636190abd9d7afe6fe9b20b5&query='+ latitude + ','+ longitude+'&forecast_days=6'; //Place your weatherstack API Call Here - access_key to be used: 5bc82451636190abd9d7afe6fe9b20b5

  $.ajax({url:url, dataType:"jsonp"}).then(function(data) {
    console.log(data);
    console.log("Current Temp: " + data.current.temperature);
    var current_time = new Date(data.location.localtime);//Retrieve the current timestamp
    console.log(current_time.getDay());
    /*
      Read the current weather information from the data point values [https://weatherstack.com/documentation] to
      update the webpage for today's weather:
      1. image_today : This should display an image for today's weather.
               This will use the icon that is returned by the API. You will be looking for the weather_icons key in the response.
    */
      
      var image = document.getElementById("image_today");
      image.src = data.current.weather_icons[0];

      /*2. location: This should be appended to the heading. For eg: "Today's Weather Forecast - Boulder" */

      var loc = document.getElementById("heading");
      loc.innerText = "Today's forecast - " + data.location.name;

      /*3. temp_today : This will be updated to match the current temperature. Use the getFarenheitTemp to convert the temperature from celsius to farenheit. */
      /*var temp = document.getElementById("temp_today");
      temp.innerText = getFarenheitTemp(data.current.tempurature)+" F"; */

      $("#temp_today").html("" + getFarenheitTemp(data.current.temperature) + " F");

      /* 4. thermometer_inner : Modify the height of the thermometer to match the current temperature. This means if the
        current temperature is 32 F, then the thermometer will have a height of 32%.  Please note,
        this thermometer has a lower boundary of 0 and upper boundary of 100.*/
        $("#thermometer_inner").css("height",
          getFarenheitTemp(data.current.temperature) < 0 ?
            0 : getFarenheitTemp(data.current.temperature) > 100 ?
            100 : getFarenheitTemp(data.current.temperature) + "%");
        $("#thermometer_inner").css("background-color",
          getFarenheitTemp(data.current.temperature) < 65 ?
            'blue' : getFarenheitTemp(data.current.temperature) > 85 ?
            'red' : 'grey');

      /* 5. precip_today : This will be updated to match the current probability for precipitation. Be sure to check the unit of the value returned and append that to the value displayed.*/

      $("#precip_today").html("" + data.current.precip + "%");

      /*6. humidity_today : This will be updated to match the current humidity percentage (make sure this is listed as a
                percentage %) */

      $("#humidity_today").html("" + data.current.humidity + "%");

      /* 7. wind_today : This will be updated to match the current wind speed. */

      $("#wind_today").html("" + data.current.wind_speed);

      /* 8. summary_today: This will be updated to match the current summary for the day's weather. */

      $("#summary_today").html(data.current.weather_descriptions);

    //helper function - to be used to get the key for each of the 5 days in the future when creating cards for forecasting weather
    function getKey(i){
        var week_names = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday','Sunday'];
        dayOfWeek=week_names[new Date(Object.keys(data.forecast)[i]).getDay()];
        return data.forecast[Object.keys(data.forecast)[i]];
    }
    /* Process the daily forecast for the next 5 days */

    /*
      For the next 5 days you'll need to add a new card listing:
        1. The day of the week
        2. The temperature high
        3. The temperature low
        4. Sunrise
        5. Sunset

      Each card should use the following format:
      <div style="width: 20%;">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title"><!-- List Day of the Week Here --></h5>
            <p class="card-text">High:<!--List Temperature High --> <br>
              Low: <!-- List Temperature Low --><br>
              Sunrise: <!-- List Time of Sunrise --><br>
              Sunset: <!-- List Time of Sunset --></p>
          </div>
        </div>
      </div>

      <Hint1 - To access the forecast data> You need to make sure to carefully see the JSON response to see how to access the forecast data. While creating the key to access forecast data make sure to convert it into a string using the toString() method.

      <Hint2 - To add the cards to the HTML> - Make sure to use string concatenation to add the html code for the daily weather cards.  This should
      be set to the innerHTML for the 5_day_forecast.
    */
    
    /*creates every card here w/all info */
     $.each(data.forecast, function(i, d){
          var month = d.date.substring(5,7);
          var date = d.date.substring(8);
          var year = d.date.substring(0,4);
          console.log(month, date, year);
          $("#5_day_forecast").append('<div style="width: 20%;"><div class="card"><div class="card-body"><h5 class="card-title">'+
            getDayofWeek(date, month, year)+
            '</h5><p class="card-text">High: '+ getFarenheitTemp(d.maxtemp)+
            '<br>Low: '+ getFarenheitTemp(d.mintemp)+
            '<br>Sunrise: '+ d.astro.sunrise+
            '<br>Sunset: '+ d.astro.sunset+
            '</p></div></div></div>');
          })
    });

        /*dynamically allocated latitude and lon */
        $(document).ready(function() {
          run('https://api.weatherstack.com/forecast?access_key=5bc82451636190abd9d7afe6fe9b20b5&query=Boulder&forecast_days=5');
        })
        
        var runLatLon = function(){
          var lat = $("#lat").val();
          var lon = $("#lon").val();
          var ur = 'http://open.mapquestapi.com/geocoding/v1/reverse?key=qpJZGcUmCEvanI7k4r8cURGBW4qBC7Me&location=' + lat + ',' + lon + '';
          $.ajax({url:ur, dataType:"jsonp"}).then(function(data) {
            console.log(data);
            var url = 'https://api.weatherstack.com/forecast?access_key=5bc82451636190abd9d7afe6fe9b20b5&query=' + data.results[0].locations[0].adminArea5 + '&forecast_days=';
            run(url);
          })
        }
    });

