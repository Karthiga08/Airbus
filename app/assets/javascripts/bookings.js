$(document).ready(function() {
  let total_check_box = $('input:checkbox').length;
  let checked_box = $('input:checkbox:checked').length;
  let unchecked_box = $('input:checkbox:not(":checked")').length;
  let balance = total_check_box - checked_box
  console.log(balance, 'bal')
  console.log(total_check_box/2 , 'tot')
  if (total_check_box/2 >= balance) {
    console.log("true")
  }
})