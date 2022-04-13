require "rails_helper"

RSpec.describe "Likes", type: :request do
  describe "POST /posts/:post_id/likes" do
    let(:req) { post post_likes_path(post_id) }

    context "with user and valid post_id" do
      let(:user) { create(:user) }
      let(:post_id) { create(:post).id }

      before { login_as user }

      it "creates a new like" do
        expect { req }.to change(Like, :count).by 1
      end

      it "associates the like with the logged in user" do
        req

        expect(Like.last.user).to eq user
      end

      it "redirects to current post" do
        req
        expect(response).to redirect_to post_path(post_id)
      end
    end

    context "without a user" do
      let(:post_id) { create(:post).id }

      it "does not create a new like" do
        expect { req }.not_to change(Like, :count)
      end

      it "redirects to the new session url" do
        req
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "with invalid post id" do
      let(:user) { create(:user) }
      let(:post_id) { rand(1..1000) }

      before { login_as user }

      it "returns not found" do
        req
        expect(response.status).to eq(404)
      end
    end
  end
end
