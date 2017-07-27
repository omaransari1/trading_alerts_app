require "rails_helper"

RSpec.describe StocksController do
  describe "GET index" do
    # it "assigns @teams" do
    #   team = Team.create
    #   get :index
    #   expect(assigns(:teams)).to eq([team])
    # end

    it "renders the index template" do
      user = double('user', :id => 1)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(response).to render_template('watchlist.html.erb')
    end

    it "returns an HTTP status code 200" do
      user = double('user', :id => 1)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(response).to have_http_status(200)

    end
  end
end
