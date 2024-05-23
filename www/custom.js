$(document).on('shiny:inputchanged', function(event) {
  if(event.name === 'alert_btn') {
    alert('This is the triggered JavaScript from custom.js in www/');
  }
});
