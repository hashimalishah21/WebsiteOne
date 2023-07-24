module ApplicationHelper
  def gravatar_for(email, options = { size: 80 })
    hash = Digest::MD5::hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}&d=mm"
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_projects
    Project.all
  end

  def social_button(provider, options={})
    provider = provider.downcase
    display_name = {
        'github' => 'GitHub',
        'gplus'  => 'Google+'
    }

    fa_icon = {
        'github' => 'github-alt',
        'gplus'  => 'google-plus'
    }

    text = options[:delete] ? 'Remove' : 'Connect with'
    raw %Q{<a class="btn btn-lg btn-block btn-social btn-#{provider}" #{'method="delete" ' if options[:delete]}}+
            %Q{href="/auth/#{provider}#{"?origin=#{CGI.escape(options[:url].gsub(/^[\/]*/, '/'))}" if options[:url].present?}">} +
            %Q{<i class="fa fa-#{fa_icon[provider]}"></i> #{text} #{display_name[provider]}</a>}
  end

  def supported_third_parties
    %w{ github gplus }
  end
end
