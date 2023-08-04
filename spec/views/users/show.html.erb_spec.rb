require 'spec_helper'

describe "users/show.html.erb" do
	before :each do
	  @user = mock_model(User, id: 4,
                             first_name: 'Eric',
                             last_name: 'Els',
                             email: 'eric@somemail.se',
                             created_at: Date.new(2014, 1, 1)
                      )
		assign :user, @user
    @youtube_videos = [
        {
            url: "http://www.youtube.com/100",
            title: "Random",
            published: '01/01/2015'.to_date
        },
        {
            url: "http://www.youtube.com/340",
            title: "Stuff",
            published: '01/01/2015'.to_date
        },
        {
            url: "http://www.youtube.com/2340",
            title: "Here's something",
            published: '01/01/2015'.to_date
        }
    ]
    assign :youtube_videos, @youtube_videos
	end

  it 'renders list of youtube links and published dates if user has videos' do
    render
    @youtube_videos.each do |link|
      expect(rendered).to have_link(link[:title], :href => link[:url])
    end
  end
  it 'renders "no available videos" if user has no videos' do
    assign(:youtube_videos, nil)
    render
    expect(rendered).to have_text("Eric Els has no publicly viewable Youtube videos.")
  end

  it 'renders "connect youtube channel" when user views his profile and it is not yet connected'

  it 'renders big user avatar' do
    expect(view).to receive(:gravatar_for).with(@user.email ,size: 275).and_return('img_link')
    render
    expect(rendered).to have_css('img')
    expect(rendered).to have_xpath("//img[contains(@src, 'img_link')]")
  end
  it 'renders user first and last names' do
  	render
  	expect(rendered).to have_content(@user.first_name)
  	expect(rendered).to have_content(@user.last_name)
  end

  it 'show link to GitHub profile' do
  	pending("requires github API integration")
  end

  it 'should not display an edit button if it is not my profile' do
    @user_logged_in ||= FactoryGirl.create :user
    sign_in @user_logged_in

    render
    expect(rendered).not_to have_link('Edit', href: '/users/edit')
  end

  it 'should display Joined on ..' do
    Date.stub(today:'07/02/2014'.to_date)
    render
    expect(rendered).to have_text('Member for: about 1 month')
  end

  context 'users own profile page' do
    before :each do
        @user_logged_in ||= FactoryGirl.create :user
        sign_in @user_logged_in # method from devise:TestHelpers
    end
    it 'displays an edit button if it is my profile' do
      render
      expect(rendered).to_not have_xpath("//a[contains(@type, 'button')]")
    end


  end

  it 'renders list of followed projects'
  it 'renders user statistics'
end
