module DeviceHelper

  def create_input_form_for_username(f)
    f.input :username, required: true, autofocus: true, :wrapper_html => {:class => 'col-lg-6'},
      :input_html => {:size => 60, :class => 'form-control col-lg-7', :placeholder => 'ユーザ名'}
  end

  def create_input_form_for_email(f)
    f.input :email, required: true, autofocus: true, :wrapper_html => {:class => 'col-lg-7'},
      :input_html => {:size => 60, :class => 'form-control', :placeholder => 'メールアドレス'}
  end

  def create_input_form_for_password(f)
    f.input :password, required: true, :wrapper_html => {:class => 'col-lg-6'},
      :input_html => {:size => 20, :class => 'form-control', :placeholder => 'パスワード'}
  end

end
