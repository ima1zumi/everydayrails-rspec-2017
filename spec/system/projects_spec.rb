require 'rails_helper'

RSpec.describe "Projects", type: :system do
  describe "project create" do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in_as(user)
    end

    context "with project name and description" do
      scenario 'user creates a new project' do
        click_link "New Project"
        fill_in "Name", with: "tama.rb"
        fill_in "Description", with: "omotesando"
        expect {
          click_button "Create Project"
        }.to change(user.projects, :count).by(1)
        expect(page).to have_content "Project was successfully created"
        expect(page).to have_content "tama.rb"
      end
    end

    context "with empty project name" do
      scenario "user can't create a new project" do
        click_link "New Project"
        fill_in "Name", with: ""
        fill_in "Description", with: "omotesando"
        expect {
          click_button "Create Project"
        }.to_not change(user.projects, :count)
        expect(page).to have_content "Name can't be blank"
      end
    end
  end
end
