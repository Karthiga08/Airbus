function cancelTicket(seat, user){
  $('.loader-visible').show();
  var url = "/cancel_seats"
  $.ajax({
    type: 'post',
    url: url,
    data: { seat_id: seat, id: user },
    success: function(data) {
      var url = window.location.href;
      if (url.indexOf('?') > -1){
         url += '&user_id='+user
      }else{
         url += '?user_id='+user
      }
      window.location.href = url;
    },
    error: function (response) {
      console.log("error")
    }
  });
}

function closeModal(){
  window.location.reload();
}

function loadUpperClass(element){
  data = $(element).data('categories')
  category_id = $(element).data('id')
  var appenddata = '<option disabled selected value> Select a Category </option>'
  $.each(data, function (key, value) {
    appenddata += '<option data-id='+ category_id +' value = '+ value.id +'>' + value.name + '</option>';
  });
  $('#category-list').html(appenddata);
}

function search(nameKey, myArray){
  for (var i=0; i < myArray.length; i++) {
    if (myArray[i].id === nameKey) {
        return myArray[i];
    }
  }
}

function changeCategoryList(plane_id){
  $.ajax({
    type: "GET",
    url: "/seat_vacancies",
    data: { plane_id: plane_id, category_id:$('#category-list').val(), id: $('#category-list').find(':selected').data('id') },
    success: function(data){
      var seat_data = ''
      $.each(data.seats, function (key, value) {
        var lib = search(value.seat_category_id, data.categories)
        var col_al = 12/lib.number_of_seat_in_row
        var check_box_value = value.is_booked? 'disabled' : 'enabled'
        seat_data += '<li class="col-xs-' + col_al + '"><input type="checkbox" name="seat_id" value='+ value.id + ' '+ check_box_value + '>'+value.seat_number+'<br></li>'
      })
      $('#vacancy-seat-list').html(seat_data);
    },
    error: function (response) {
      console.log(response)
    }
  });
}


function bookUpgradeTicket(user_id){
  var booked_seats = []
  $.each($("input[name='seat_id']:checked"), function(){
    booked_seats.push($(this).val());
  });
  var seat_pnr = $("#pnr_number").text().trim();

  if (booked_seats) {
    return(
      $('#error_check').html('<span class="error">Please select any seats</span>')
    )
  }
 $.ajax({
  type: "POST",
  url: "/upgrade_seats",
  data: { user_id: user_id, selected_seats: booked_seats, pnr_number: seat_pnr },
  success: function(data){
    var seat_data = ''
    $.each(data.seats, function (key, value) {
      seat_data += '<li class="col-xs-6"><input type="checkbox" name="seat_id" value='+ value.id + '>'+value.seat_number+'<br></li>'
    })
    $('#vacancy-seat-list').html(seat_data);
  },
  error: function (response) {
    console.log(response)
  }
});
}
