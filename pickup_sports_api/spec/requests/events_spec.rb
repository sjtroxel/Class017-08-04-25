require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) {create(:user)}
  let(:token) { auth_token_for_user(user) }

  # get events - index
  describe "GET /events" do
    it 'returns a response with all of the events' do
      create(:event)
      get '/events', headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(Event.all.to_json)
    end
  end 

  # get events - show
  describe "GET /event" do
    let (:event) { create(:event) }

    it "returns a response with the specified event" do
      get "/events/#{event.id}", headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(event.to_json)
    end
  end

  # create event - create
  describe "POST /events" do
    let(:user) { create(:user) }
    let(:token) { auth_token_for_user(user) }
    let(:sport) { create(:sport) }
    let(:event_attributes) { attributes_for(:event, sport_ids: [sport.id]) }

    before do
      post "/events", params: event_attributes, headers: { Authorization: "Bearer #{token}" }
    end

    it "creates a new event" do
      expect(Event.count).to eq(1)
    end

    it "returns success response" do
      expect(response).to be_successful
    end
  end

  # update event - update
  describe "PUT /events/:id" do
    let(:user) { create(:user) }
    let(:token) { auth_token_for_user(user) }
    let (:event) { create(:event) }

    before do
      put "/events/#{event.id}", params: {title: "New Title"}, headers: { Authorization: "Bearer #{token}" }
    end

    it "updates an event" do
      event.reload
      expect(event.title).to eq("New Title")
    end
  end

  # delete event - destroy
  describe "DELETE /events/:id" do
    let(:user) { create(:user) }
    let(:token) { auth_token_for_user(user) }
    let (:event) { create(:event) }

    before do
      delete "/events/#{event.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it "deletes an event" do
      expect(Event.count).to eq(0)
    end

    it "destroy event participants" do
      event_participants = EventParticipant.where(event_id: event.id)
      expect(event_participants).to be_empty
    end

  end
end
