class ImageUrlValidator < ActiveModel::Validator
  def validate(record)
    validate_image_url(record) if record.image_url.present?
  end

  private

  def validate_image_url(record)
    #image_url = record.image_url
    #validates_format_of :image, :with => %r{\.(png|jpg|jpeg)$}i, :message => "whatever"

    match = image_url.match(/^(?:https|http|)[:\/]*www\.#{}\/s\/projects\/(\d+)$/i)
    # if match.present?
    #   pv_id = match.captures[0]
    # elsif url =~ /^\d+$/
    #   pv_id = url
    # end

    # if pv_id.present?
    #   # tidy up URL
    #   record.pivotaltracker_url = "https://www.pivotaltracker.com/s/projects/#{pv_id}"
    # else
    #   record.errors[:pivotaltracker_url] << 'Invalid Pivotal Tracker URL'
    # end
  end
end