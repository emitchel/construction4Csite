class PagesController < ApplicationController
  before_action :check_service, only: [:services]
  skip_before_action :verify_authenticity_token, only: [:contact_us]
  helper_method :active_class

  def index;
  end

  def about;
  end

  def contact;
  end

  def contact_us
    lead = Lead.new(name: params[:name], phone: params[:phone], email: params[:email], message: params[:message], source: params[:how])
    lead.save
    render json: {success: LeadEmailer.email_lead(lead)}
  end


  def services
    @service_shape = get_service_content
    @pictures = get_images(@service_shape[:url])
  end

  def active_class(service_in_question)
    if service_in_question == service_param
      'active'
    else
      ''
    end
  end

  private

  BATHROOM_REMODELING = {url: 'bathroom-remodeling',
                        title: 'Bathroom Remodeling',
                        description: 'Bathroom remodeling can be a daunting experience.  Let our many years of experience work for
                        you by keeping the stress out of your project.  4C Construction offers a total solution approach to
                        the bathroom remodel process.  We will coordinate the entire process from design to
                        completion.
                        <p>Our award winning-bathroom design and construction team will work closely with you to
                        personalize your bathroom remodeling project. We believe you deserve exceptional quality and
                        value when you remodel your bathroom. We take great pride in delivering not only high-quality
                        work, but a reliable experience. A newly designed bathroom can raise the value of your home,
                        which is a huge benefit if you have plans to sell it during the next several years.</p>',
                        background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609384908/house-renovation/bath1_oubgy4.jpg'}.freeze

  KITCHEN_REMODELING = {url: 'kitchen-remodeling',
                      title: 'Kitchen Remodeling',
                      description: 'The kitchen is the heart of the home. Because it is such a busy area and is used every day, it can
                      also be a place that shows a lot of wear and tear. Why not make this a place that your family
                      wants to gather? Our team at 4C have the design and installation experts to help you transform
                      this busy area of your home into a beautiful, yet functional showplace! Every product and detail
                      is carefully installed to the best standards. You will not find a better in value in kitchen
                      renovation better than us. All workmanship is warrantied.',
                      background_picture: 'http://res.cloudinary.com/hddupyjhs/image/upload/v1609714072/kitchen-remodeling/k2_rcdkqu.jpg'}.freeze 

  HOUSE_RENOVATION = {url: 'house-renovation',
                        title: 'House Renovation',
                        description: 'When you start a home remodeling activity you want something better, of higher quality and everything must fit your taste completely. Are you a homeowner looking for a general contractor for your remodeling project? Do you need a reliable, on time contractor that can commit to a short-term or long-term project? Then look no further. We here at 4C want to make sure that your remodeling will not only be what you want but also fit your budget.' \
                        '<p>Our mission is to provide you with a complete solution to all your construction needs. We will assist you from start to finish of your project. we’ll help you with the planning stage, your budget parameters, the time frame, permits if needed, and review the estimate with you to ensure everything as you need it prior to the start of the project.</p>',
                        background_picture: 'http://res.cloudinary.com/hddupyjhs/image/upload/v1609707216/house-renovation/familytokitchen_p1zig3.jpg'}.freeze
  DECKS_AND_CARPENTRY = {url: 'decks-and-carpentry',
                       title: 'Decks & Carpentry',
                       description: 'Are you ready to have your expectations exceeded? Are you ready to be the envy of the neighborhood? Are you ready to have a pleasant contracting experience that will add value to your home? 4C is committed to excellence in design and execution of all deck and carpentry design projects. Armed with innovative design capabilities, building technique and the tools and equipment to get the job done. 4C is always “thinking outside the box”.  Always pushing the envelope of quality, elegant simplicity and well balanced design for the discriminating client.',
                       background_picture: 'http://res.cloudinary.com/hddupyjhs/image/upload/v1609713814/decks-and-carpentry/20200817_154750_resized_eidtvv.jpg'}.freeze
  CUSTOM_HOME_BUILDING = {url: 'custom-home-building',
                           title: 'Custom Home Building',
                           description: 'We design our homes for livability. Distinctive exteriors, gracious interior spaces, and outdoor living areas all reflect the way that families and individuals live today. Our homes are built with superior-quality materials by the industry’s top craftsmen. Our on-site building team oversees each home during the construction process from the time the concrete is poured to the final walkthrough to ensure your new home meets your needs.',
                           background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609381826/custom-home-building/homes_backdrop.jpg'}.freeze

  def get_images(service_url)
    Cloudinary::Api.resources(:type => :upload, :prefix => "#{service_url}/", :max_results => 100)["resources"].map { |str| str["url"] }
  end

  def service_param
    params[:service]
  end

  def get_service_content
    if service_param == HOUSE_RENOVATION[:url]
      HOUSE_RENOVATION
    elsif service_param == DECKS_AND_CARPENTRY[:url]
      DECKS_AND_CARPENTRY
    elsif service_param == CUSTOM_HOME_BUILDING[:url]
      CUSTOM_HOME_BUILDING
    elsif service_param == BATHROOM_REMODELING[:url]
      BATHROOM_REMODELING
    elsif service_param == KITCHEN_REMODELING[:url]
      KITCHEN_REMODELING
    else 
      nil
    end
  end

  def check_service
    raise ActionController::RoutingError.new('Not Found') unless get_service_content != nil
  end
end
