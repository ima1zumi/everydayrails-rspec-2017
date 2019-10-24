require 'rails_helper'

RSpec.describe "Projects", type: :system do
  describe "project create" do
    let(:user) { FactoryBot.create(:user, first_name: 'Alice', last_name: 'Ito') }

    scenario 'user creates a new project' do
      sign_in_as(user)
      click_link "New Project"

      # 検証エラーが発生する場合
      fill_in "Name", with: ""
      fill_in "Description", with: "omotesando"
      expect {
        click_button "Create Project"
      }.to_not change(user.projects, :count)
      expect(page).to have_content "Name can't be blank"

      # 正常な値を入力した場合
      fill_in "Name", with: "tama.rb"
      expect {
        click_button "Create Project"
      }.to change(user.projects, :count).by(1)
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "tama.rb"
      expect(page).to have_content "omotesando"
      expect(page).to have_content "Owner: Alice Ito"
    end
  end
end
