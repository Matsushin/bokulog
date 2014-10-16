$(document).on 'page:change', ->
  $('.result-form').on 'ajax:success', ->
    alert('登録完了しました')
    $(this).html('本棚に登録済み')

  $('.result-form').on 'ajax:error', ->
    alert('登録に失敗しました')
