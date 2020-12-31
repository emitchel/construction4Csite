class PagesController < ApplicationController
  before_action :check_service, only: [:services]
  skip_before_action :verify_authenticity_token, only: [:contact_us]

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
    service = service_content
    @house_reno_active = active?('remodeling')
    @carpentry_active = active?('carpentry')
    @custom_homes_active = active?('homes')
    @kitchen_active =active?('kitchen')
    @bathroom =active?('bathroom')

    @service_title = service[:title]
    @subtitle = service[:subtitle]
    @description = service[:description]
    @background_picture = service[:background_picture]
    @pictures = service[:pictures]
  end

  private

  SUPPORTED_SERVICES = %w[remodeling carpentry homes kitchen bathroom].freeze

  BATHROOM_SERVICE = {title: 'Bathroom Remodeling',
                        subtitle: 'Bathroom Remodeling',
                        description: 'Bathroom remodeling can be a daunting experience.  Let our many years of experience work for
                        you by keeping the stress out of your project.  4C Construction offers a total solution approach to
                        the bathroom remodel process.  We will coordinate the entire process from design to
                        completion.
                        <p>Our award winning-bathroom design and construction team will work closely with you to
                        personalize your bathroom remodeling project. We believe you deserve exceptional quality and
                        value when you remodel your bathroom. We take great pride in delivering not only high-quality
                        work, but a reliable experience. A newly designed bathroom can raise the value of your home,
                        which is a huge benefit if you have plans to sell it during the next several years.</p>',
                        background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609384908/remodeling/bath1_oubgy4.jpg',
                        pictures: ['reno1.jpg', 'familytokitchen.jpg', 'reno2.jpg']}.freeze

  KITCHEN_SERVICE = {title: 'Kitchen Remodeling',
                      subtitle: 'Kitchen Remodeling',
                      description: 'The kitchen is the heart of the home. Because it is such a busy area and is used every day, it can
                      also be a place that shows a lot of wear and tear. Why not make this a place that your family
                      wants to gather? Our team at 4C have the design and installation experts to help you transform
                      this busy area of your home into a beautiful, yet functional showplace! Every product and detail
                      is carefully installed to the best standards. You will not find a better in value in kitchen
                      renovation better than us. All workmanship is warrantied.',
                      background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609384908/remodeling/bath1_oubgy4.jpg',
                      pictures: ['reno1.jpg', 'familytokitchen.jpg', 'reno2.jpg']}.freeze 

  REMODELING_SERVICE = {title: 'Remodeling Service',
                        subtitle: 'Home Remodeling',
                        description: 'When you start a home remodeling activity you want something better, of higher quality and everything must fit your taste completely. Are you a homeowner looking for a general contractor for your remodeling project? Do you need a reliable, on time contractor that can commit to a short-term or long-term project? Then look no further. We here at 4C want to make sure that your remodeling will not only be what you want but also fit your budget.' \
                        '<p>Our mission is to provide you with a complete solution to all your construction needs. We will assist you from start to finish of your project. we’ll help you with the planning stage, your budget parameters, the time frame, permits if needed, and review the estimate with you to ensure everything as you need it prior to the start of the project.</p>',
                        background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609384908/remodeling/bath1_oubgy4.jpg',
                        pictures: ['reno1.jpg', 'familytokitchen.jpg', 'reno2.jpg']}.freeze
  CARPENTRY_SERVICE = {title: 'Carpentry Service',
                       subtitle: 'Decks & Carpentry',
                       description: 'Are you ready to have your expectations exceeded? Are you ready to be the envy of the neighborhood? Are you ready to have a pleasant contracting experience that will add value to your home? 4C is committed to excellence in design and execution of all deck and carpentry design projects. Armed with innovative design capabilities, building technique and the tools and equipment to get the job done. 4C is always “thinking outside the box”.  Always pushing the envelope of quality, elegant simplicity and well balanced design for the discriminating client.',
                       background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609382900/carpentry/carpentry_backdrop.jpg',
                       pictures: ['5.jpg', 'goodeck.jpg', 'familyroom3.jpg']}.freeze
  HOME_BUILDING_SERVICE = {title: 'Home Building Service',
                           subtitle: 'Custom Home Building',
                           description: 'We design our homes for livability. Distinctive exteriors, gracious interior spaces, and outdoor living areas all reflect the way that families and individuals live today. Our homes are built with superior-quality materials by the industry’s top craftsmen. Our on-site building team oversees each home during the construction process from the time the concrete is poured to the final walkthrough to ensure your new home meets your needs.',
                           background_picture: 'https://res.cloudinary.com/hddupyjhs/image/upload/v1609381826/homes/homes_backdrop.jpg',
                           pictures: %w[17.jpg 18.jpg 19.jpg 20.jpg 21.jpg 22.jpg 23.jpg 24.jpg 25.jpg 26.jpg 27.jpg 28.jpg 29.jpg 30.jpg
                           Front.jpg 3.jpg basement1.jpg 4.jpg 5.jpg 6.jpg 7.jpg 9.jpg b1.jpg b1p2.jpg b1p3.jpg 
                           b11.jpg b12.jpg bath1.jpg by1.jpg by2.jpg e.jpg e1.jpg e2.jpg f1.jpg f2.jpg familyroom1.jpg
                           familyroom3.jpg familytokitchen.jpg fr2.jpg Front.jpg frontside1.jpg frontside2.jpg g2.jpg g3.jpg
                           k2.jpg k5.jpg k6.jpg kitchen3.jpg kitchen4.jpg l1.jpg l2.jpg l3.jpg livingtoentry.jpg m1.jpg m2.jpg
                           m3.jpg mb1.jpg mb2.jpg mb3.jpg mb4.jpg mbd1.jpg mbd2.jpg mbd3.jpg r1.jpg r2.jpg reno1.jpg reno2.jpg]}.freeze

  def check_service
    raise ActionController::RoutingError.new('Not Found') unless SUPPORTED_SERVICES.include?(service)
  end

  def service
    params[:service]
  end

  def active?(service_in_question)
    if service_in_question == service
      'active'
    else
      ''
    end
  end

  def service_content
    if service == 'remodeling'
      REMODELING_SERVICE
    elsif service == 'carpentry'
      CARPENTRY_SERVICE
    elsif service == 'homes'
      HOME_BUILDING_SERVICE
    elsif service == 'bathroom'
      BATHROOM_SERVICE
    elsif service == 'kitchen'
      KITCHEN_SERVICE
    end
  end
end
