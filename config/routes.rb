Rails.application.routes.draw do
  # Authentication, taken from https://gist.github.com/chrishough/6dd44fc841e80bbc2265
  # devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations]
  # as :user do
    # session handling
    # get     '/login'  => 'devise/sessions#new',     as: 'new_person_session'
    # post    '/login'  => 'devise/sessions#create',  as: 'person_session'
    # delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_person_session'

    # registration
    # get   '/join' => 'devise/registrations#new',    as: 'new_person_registration'
    post '/users', to: 'users#create', as: 'user_registration'

    # scope '/account' do
      # password reset
      # get   '/reset-password'        => 'devise/passwords#new',    as: 'new_person_password'
      # put   '/reset-password'        => 'devise/passwords#update', as: 'person_password'
      # post  '/reset-password'        => 'devise/passwords#create'
      # get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_person_password'

      # confirmation
      # get   '/confirm'        => 'devise/confirmations#show',   as: 'person_confirmation'
      # post  '/confirm'        => 'devise/confirmations#create'
      # get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_person_confirmation'

      # settings & cancellation
      # get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_person_registration'
      # get '/settings' => 'devise/registrations#edit',   as: 'edit_person_registration'
      # put '/settings' => 'devise/registrations#update'

      # account deletion
      # delete '' => 'devise/registrations#destroy'
    # end
  # end
end
