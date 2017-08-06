$(document).ready( function() {
  document.body.onkeyup = function(e){
    if($('.disable-speak').length > 0){
      return;
    }
    if(e.keyCode == 32){
      AudioAnimal.speak()
    }
  }
  $('#jsReset').on('click', function(e){
    e.preventDefault();
    $('#jsTotalAudio').val('')
    $('.jsPanel').html('')
  })

  $('#jsAdd').on('click', function(e){
    e.preventDefault();
    var data = {from: '', to: ''}
    var templates = AudioAnimal.template(data)
    $('.jsPanel').append(templates)
    bindDelete()
    bindRun()
  })


  $('#jsProgress').on('click', function(e){
    e.preventDefault()
    if( $('#jsTotalAudio').val() == '' ){
      return false
    }
    $('.jsPanel').html('')
    var audios = $('#jsTotalAudio').val().split(',')
    if($('.jsOption:checked').val() == 0){
      audios.unshift(0)
      audios.push(+$('.sm2-inline-duration').html().split(':')[0]*60 + +$('.sm2-inline-duration').html().split(':')[1])
    }
    var arrayResults = []
    if( $('.jsOption:checked').val() == '1'){
      while (audios.length > 0) {
        arrayResults.push([audios[0], audios[1]])
        audios.splice(0, 2)
      }
    }else{
      while (audios.length > 0) {
        arrayResults.push([audios[0], audios[1]])
        audios.splice(0, 1)
      }
    }
    var templates = ''
    _.each(arrayResults, function(e){
      var data = {from: e[0], to: e[1]}
      templates += AudioAnimal.template(data)
    })
    $('.jsPanel').append(templates)
    bindDelete()
    bindRun()
  })

  $('#jsUp').on('click', function(e){
    e.preventDefault()
    var data = []
    $.each($('.jsSubPanel input'), function(index, input){ data.push( $(input).val() ) } )
    $.ajax({
      url: '/audios/p_audio',
      type: 'POST',
      dataType: 'json',
      data: { durations: data, index_link: sm2BarPlayers[0].playlistController.data.selectedIndex, link: sm2BarPlayers[0].playlistController.getURL(), option: $('.jsOption:checked').val(), vol_aulm_id: $('.jsPanel').data('vol') }
    }).success(function( res ) {

    });

  })

  var bindDelete = function(){
    $('.jsDelete').on('click', function(e){
      e.preventDefault();
      $(e.currentTarget).parents('.jsSubPanel').remove()
    })
  }
  var bindRun = function(){
    $('.jsRun').on('click', function(e){
      e.preventDefault();
      var parent = $(e.currentTarget).parents('.jsSubPanel')
      var from = parent.find('.first').val()
      var to = parent.find('.last').val()
      var selectedIndex = sm2BarPlayers[0].playlistController.data.selectedIndex
      sm2BarPlayers[0].actions.play(selectedIndex, {from: +from*1000, to: +to*1000})
    })
  }

  $('.jsProgressA').trigger('click')
  if ($('.audioChecked').length > 0) {
    setTimeout(function(){
      sm2BarPlayers[0].playlistController.select($('.audioChecked')[0])
    }, 1000);
  }

  function runByKey(e) {
    e = e || window.event;
    if (e.keyCode >= 48 && e.keyCode <= 57) {

    }
  }
  if ($('.duration-show').length > 0){
    document.onkeydown = runByKey;
  }


});

function AudioAnimal() {
}

AudioAnimal.template = function(data){
  var compiled = _.template("<div class='col-sm-4 jsSubPanel'><div class='form-group col-sm-4'><label class='control-label' for=''>First</label><input autocomplete='off' class='form-control first' id='' name='' value='<%= from %>' type='text'/></div><div class='form-group col-sm-4'><label class='control-label' for=''>Last</label><input autocomplete='off' class='form-control last' id='' name='' value='<%= to %>' type='text'/></div><div class='form-group col-sm-2'><label class='control-label'>&nbsp;</label><button class='btn btn-primary jsRun' type='button'>Run</button></div><div class='form-group col-sm-2'><label class='control-label'>&nbsp;</label><button class='jsDelete btn btn-primary' type='button'>Delete</button></div></div>")
  return compiled(data);
}

AudioAnimal.speak = function(){
  if( $('#jsTotalAudio').length < 1 ) return;
  var old = $('#jsTotalAudio').val()
  var newV = ''
  if(old == ''){
    newV = current_position
  }else{
    newV = old + ',' + current_position
  }
  $('#jsTotalAudio').val(newV)
}
