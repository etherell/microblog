require "rails_helper"

RSpec.describe Like, type: :model do
  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe "field" do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:post_id).of_type(:integer) }
  end

  describe "index" do
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:post_id) }
  end
end
