require 'rails_helper'

describe 'Registration', type: :request do
  JSONAPI_SCHEMA = 'jsonapi'
  TEST_SETTINGS = [
    %w(KEY_1 KEY_1_DESCRIPTION 10),
    %w(KEY_2 KEY_2_DESCRIPTION 20),
    %w(KEY_3 KEY_3_DESCRIPTION 30),
    %w(KEY_4 KEY_4_DESCRIPTION 40)
  ]

  context 'when params are valid' do
    before(:each) do
      DatabaseCleaner.start
    end
    after(:each) do
      DatabaseCleaner.clean
    end
    before(:each) do
      TEST_SETTINGS.each do |setting|
        Setting.create(setting_key:setting[0],setting_description:setting[1],default_value:setting[2])
      end
    end

    context 'when a user with the same email or username does not exist' do
      before(:each) do
        @user = build_stubbed(:user)
        @profile = build_stubbed(:profile)
        post '/users', data:{
                       'type':'users',
                       'attributes':{
                         'email':@user.email,
                         'username':@user.username,
                         'password':@user.password,
                         'relationships':[
                           {
                             'profile':{
                               'full-name':@profile.full_name,
                               'country':@profile.country
                             }
                           }
                         ]
                       }
                     }, CONTENT_TYPE: Mime::JSON, ACCEPT: Mime::JSON
      end

      it {
        expect(response).to have_http_status(:created)
      }
      it 'creates a active user with correct attributes' do
        expect(User.last.email).to eq(@user.email)
        expect(User.last.username).to eq(@user.username)
        expect(User.last.active).to eq(true)
      end

      it 'assigns the default settings' do
        user_settings = User.last.user_settings
        expect(user_settings.count).to eq(Setting.count)

        Setting.all.each do |setting|
          expect(user_settings.find(setting.id).value).to eq(setting.default_value)
        end
      end
      it 'created a profile with correct attributes' do
        profile = User.last.profile
        expect(profile).to_not be_nil
        expect(profile.full_name).to eq(@profile.full_name)
        expect(profile.country).to eq(@profile.country)
      end

    end

    context 'when a user with the same email exist' do
      before(:each) do
        @user = create(:user)
        @user_count = User.count
        @profile = build_stubbed(:profile)
        post '/users', data:{
                         'type':'users',
                         'attributes':{
                           'email':@user.email,
                           'username':'other',
                           'password':'other_other',
                           'relationships':[
                             {
                               'profile':{
                                 'full-name':@profile.full_name,
                                 'country':@profile.country
                               }
                             }
                           ]
                         }
                       }, CONTENT_TYPE: Mime::JSON, ACCEPT: Mime::JSON
      end

      it {
        expect(response).to have_http_status(:unprocessable_entity)
      }

      it 'should not create a new user' do
        expect(User.count).to eq(@user_count)
      end
    end

    context 'when a user with the same usename exist' do
      before(:each) do
        @user = create(:user)
        @user_count = User.count
        @profile = build_stubbed(:profile)
        post '/users', data:{
                       'type':'users',
                       'attributes':{
                         'email':'other@gmail.com',
                         'username':@user.username,
                         'password':'other_other',
                         'relationships':[
                           {
                             'profile':{
                               'full-name':@profile.full_name,
                               'country':@profile.country
                             }
                           }
                         ]
                       }
                     }, CONTENT_TYPE: Mime::JSON, ACCEPT: Mime::JSON
      end

      it {
        expect(response).to have_http_status(:unprocessable_entity)
      }

      it 'should not create a new user' do
        expect(User.count).to eq(@user_count)
      end
    end


    context 'when params are invalid' do
      context 'for user' do
        before(:each) do
          @user = build_stubbed(:user, email: nil)
          @user_count = User.count
          @profile = build_stubbed(:profile, )
          post '/users', data:{
                         'type':'users',
                         'attributes':{
                           'email':@user.email,
                           'username':@user.username,
                           'password':@user.password,
                           'relationships':[
                             {
                               'profile':{
                                 'full-name':@profile.full_name,
                                 'country':@profile.country
                               }
                             }
                           ]
                         }
                       }, CONTENT_TYPE: Mime::JSON, ACCEPT: Mime::JSON
        end

        it {
          expect(response).to have_http_status(:unprocessable_entity)
        }

        it 'should not create a new user' do
          expect(User.count).to eq(@user_count)
        end
      end

      context 'for profile info' do
        before(:each) do
          @user = build_stubbed(:user)
          @user_count = User.count
          @profile = build_stubbed(:profile, full_name: nil )
          post '/users', data:{
                           'type':'users',
                           'attributes':{
                             'email':@user.email,
                             'username':@user.username,
                             'password':@user.password,
                             'relationships':[
                               {
                                 'profile':{
                                   'full-name':@profile.full_name,
                                   'country':@profile.country
                                 }
                               }
                             ]
                           }
                         }, CONTENT_TYPE: Mime::JSON, ACCEPT: Mime::JSON
        end

        it {
          expect(response).to have_http_status(:unprocessable_entity)
        }

        it 'should not create a new user' do
          expect(User.count).to eq(@user_count)
        end
      end
    end

  end

end