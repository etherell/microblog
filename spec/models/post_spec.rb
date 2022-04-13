require "rails_helper"

RSpec.describe Post, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of :body }
  end

  describe "association" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end
end
