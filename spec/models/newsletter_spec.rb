require 'spec_helper'

describe Newsletter do
  it 'has a valid factory' do
    FactoryGirl.build(:newsletter).should be_valid
  end

  describe "is invalid" do
    it 'when subejct is empty' do
      FactoryGirl.build(:newsletter, subject: nil).should_not be_valid
    end

    it 'when title is emtpy' do
      FactoryGirl.build(:newsletter, title: nil).should_not be_valid
    end

    it 'when body is empty' do
      FactoryGirl.build(:newsletter, body: nil).should_not be_valid
    end
  end

  describe "class variables" do
    before do
      Newsletter.class_variable_set('@@chunk_size', Settings.newsletter.chunk_size)
      Newsletter.class_variable_set('@@send_as', Settings.newsletter.send_as)
    end

    it 'configures as scheduler_job' do
      expect(Newsletter.send_as).to eq(:scheduler_job)
    end

    it 'configures 180 recipients per run' do
      expect(Newsletter.chunk_size).to eq(180)
    end
  end

  describe 'sends mailings in instant mode' do
    before :each do 
      receiver_users = FactoryGirl.create_list(:user, 2, receive_mailings: true)
      non_receiver_users = FactoryGirl.create_list(:user, 2, receive_mailings: false)
      @newsletter = FactoryGirl.create(:newsletter)
      Newsletter.class_variable_set('@@send_as', :instant)
    end

    after :all do
      Newsletter.class_variable_set('@@chunk_size', 180)
      Newsletter.class_variable_set('@@send_as', :scheduler_job)
    end

    it 'after do_send is set to true' do
      @newsletter.do_send = true
      expect{ @newsletter.save! }.to change{ ActionMailer::Base.deliveries.count }.by(2)
    end

    it 'updates sent_at with Time' do
      @newsletter.do_send = true
      @newsletter.save
      @newsletter.reload 
      @newsletter.sent_at.should be_a(Time)
    end

    it 'updates was_sent to true' do
      @newsletter.do_send = true
      @newsletter.save
      @newsletter.reload
      expect(@newsletter.was_sent).to eq(true)
    end
  end

  describe 'does not instantely send in scheduler_job mode' do
    before :each do
      @newsletter = FactoryGirl.build(:newsletter)
    end

    it 'awaits scheduler' do
      @newsletter.do_send = true
      expect{ @newsletter.save!}.to change{ ActionMailer::Base.deliveries.count}.by(0)
    end
  end
end
