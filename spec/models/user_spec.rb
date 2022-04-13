# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "validation" do
    it "validates presence of email" do
      user = build(:user, email: nil)
      expect(user.valid?).to be false
    end

    it "validates uniqueness of email" do
      create(:user, email: "john@example.com")
      user = build(:user, email: "john@example.com")
      expect(user.valid?).to be false
    end

    it "validates presence of password" do
      user = build(:user, password: nil)
      expect(user.valid?).to be false
    end

    it "validates presence of first name" do
      user = build(:user, first_name: nil)
      expect(user.valid?).to be false
    end

    it "validates presence of last name" do
      user = build(:user, last_name: nil)
      expect(user.valid?).to be false
    end
  end

  describe "association" do
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end
end
