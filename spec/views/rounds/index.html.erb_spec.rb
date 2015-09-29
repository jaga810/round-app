require 'rails_helper'

RSpec.describe "rounds/index", type: :view do
  before(:each) do
    assign(:rounds, [
      Round.create!(
        :practice_id => 1
      ),
      Round.create!(
        :practice_id => 1
      )
    ])
  end

  it "renders a list of rounds" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
