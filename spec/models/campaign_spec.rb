require 'rails_helper'

RSpec.describe Campaign, type: :model do
  def campaign_attributes(new_attributes = {})
    { title:        "My first campaign.",
      goal:         7600,
      description:  "Reach $7,600 for boot camp.",
      end_date:     (Time.now + 20.days)
    }.merge(new_attributes)
  end


  describe "Validations" do
    it "requires a title" do
      campaign = Campaign.new campaign_attributes({title:nil})
      expect(campaign).to be_invalid
    end

    it "requires a description" do
      campaign = Campaign.new campaign_attributes({description:nil})
      expect(campaign).to be_invalid
    end

    it "requires a goal" do
      campaign = Campaign.new campaign_attributes({goal:nil})
      expect(campaign).to be_invalid
    end

    it "requires a goal greater than 10" do
      campaign = Campaign.new campaign_attributes({goal:8})
      expect(campaign).to be_invalid
    end

    it "requires the title to be unique" do
      title = "Test campaign."
      campaign1 = Campaign.create campaign_attributes({title: title})
      campaign2 = Campaign.new campaign_attributes({title: title})
      expect(campaign2).to be_invalid
    end

  end
end
