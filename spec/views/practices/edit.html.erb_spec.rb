require 'rails_helper'

RSpec.describe "practices/edit", type: :view do
  before(:each) do
    @practice = assign(:practice, Practice.create!(
      :circle_id => 1
    ))
  end

  it "renders the edit practice form" do
    render

    assert_select "form[action=?][method=?]", practice_path(@practice), "post" do

      assert_select "input#practice_circle_id[name=?]", "practice[circle_id]"
    end
  end
end
