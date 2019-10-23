require 'rails_helper'

RSpec.describe "Projects", type: :system do
  describe "project create" do
    let(:user) { FactoryBot.create(:user) }
    let(:name){ user.name }

    before do
      visit root_path
      click_link "Sign in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    subject(:new_project) {
      -> {
        click_link "New Project"
        fill_in "Name", with: project_name
        fill_in "Description", with: project_description
        click_button "Create Project"

        # MEMO: click_button とはまだ処理が完了していない可能性がある
        #       そこで以下のようなテストを実行することで「次のページがレンダリングされている」ことを保証する
        expect(page).to have_content have_content_notice
      }
    }

    context "with project name and description" do
      let(:have_content_notice) { "Project was successfully created" }
      let(:project_name) { "tama.rb" }
      let(:project_description) { "omotesando" }

      it { is_expected.to change(user.projects, :count).by(1) }
      it { is_expected.to change { page.html }.to include project_name }
    end

    context "with empty project name" do
      let(:have_content_notice) { "Name can't be blank" }
      let(:project_name) { "" }
      let(:project_description) { "omotesando" }

      it { is_expected.not_to change(user.projects, :count) }
    end

    context "with empty project description" do
      let(:have_content_notice) { "Project was successfully created" }
      let(:project_name) { "tama.rb" }
      let(:project_description) { "" }

      it { is_expected.to change(user.projects, :count).by(1) }
    end
  end
end
