RSpec.describe Api::V1::AuthController, type: :controller do
  #let(:user) { User.create(username:'test', password:'test1234') }

  describe 'POST #login' do
    #let(:user) { User.create(username:'test', password:'test1234') }
    let(:user) { create(:user) }
    #let(:user) {create(:user_with_customer_role)}
    #let(:user) { create(:admin_user) }

    context 'Happy path' do
      before do
        post :login, params: {username: user.username, password: user.password}
      end
  
      it 'user has id' do      
        expect(JSON.parse(response.body)["user"]["id"]).to eq(user.id)
      end

      it 'user has status ok' do    
        expect(response.status).to eq(200)
      end
    end

    context 'Invalid credentials' do
      before do
        post :login, params: {username: user.username, password: 'wrong_password!'}
      end

      it 'user has wrong password' do
        expect(response.status).to eq(401)
      end
    end
  end




  describe 'POST #create_user', type: :request do
    # let(:user) { User.new(username:'a_01', password:'test1234') }
    let(:user) { build(:user) }
    #  User.new(username:'a_01', password:'test1234').attributes

    context 'Happy path' do    
      before do
        post '/api/auth/create_user', params: {username: user.username, password: user.password}, headers: {Authorization: ENV['ACCESS_TOKEN']}
      end

      it 'has valid access token' do
        expect(request.headers[:Authorization]).to eq(ENV['ACCESS_TOKEN'])
      end

      it 'user succesfully created' do
        expect(JSON.parse(response.body)["user"]["access_token"]).to eq(ENV['ACCESS_TOKEN'])
      end
    end


    context 'Wrong details provided' do
      before do
        post '/api/auth/create_user', params: {username: user.username, password: user.password}, headers: {Authorization: "incorrect_access_token"}
      end

      it 'has invalid access token' do
        expect(request.headers[:Authorization]).not_to eq(ENV['ACCESS_TOKEN'])
      end
    end
  end
end