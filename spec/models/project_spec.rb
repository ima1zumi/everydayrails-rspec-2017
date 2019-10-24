require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

  describe 'validation' do
    let(:project) { FactoryBot.build(:project) }
    context 'with empty name' do
      it 'is invalid' do
        project.name = ''
        expect(project).to be_invalid
      end
    end
    context 'with empty description' do
      it 'is valid' do
        project.description = ''
        expect(project).to be_valid
      end
    end
  end
end
