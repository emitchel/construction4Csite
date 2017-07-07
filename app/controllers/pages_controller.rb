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
    lead = Lead.new(name: params[:name], email: params[:email], message: params[:message], source: params[:how])
    lead.save
    render json: {success: LeadEmailer.email_lead(lead)}
  end


  def services
    service = service_content
    @house_reno_active = active?('renovation')
    @carpentry_active = active?('carpentry')
    @custom_homes_active = active?('homes')
    @service_title = service[:title]
    @subtitle = service[:subtitle]
    @description = service[:description]
    @background_picture = service[:background_picture]
    @picture1 = service[:picture1]
    @picture2 = service[:picture2]
    @picture3 = service[:picture3]
  end

  private

  SUPPORTED_SERVICES = %w[renovation carpentry homes].freeze

  RENOVATION_SERVICE = { title: 'Renovation Service',
                        subtitle: 'House Renovation',
                        description: 'Bathrooms, kitchens, bedrooms, entire basements, renovations are a great route for adding that personal touch',
                        background_picture: '/assets/bath1.jpg',
                        picture1: '/assets/reno1.jpg',
                        picture2: '/assets/reno2.jpg',
                        picture3: '/assets/familytokitchen.jpg' }.freeze
  CARPENTRY_SERVICE = { title: 'Carpentry Service',
                       subtitle: 'Decks & Carpentry',
                       description: 'While we do specialize in customized decks, any type of carpentry isn\'t out of the question',
                       background_picture: '/assets/15.jpg',
                       picture1: '/assets/5.jpg',
                       picture2: '/assets/goodeck.jpg',
                       picture3: '/assets/familyroom3.jpg' }.freeze
  HOME_BUILDING_SERVICE = { title: 'Home Building Service',
                           subtitle: 'Custom Home Building',
                           description: 'As far as custom home building we do everything. Custom kitchens, bathrooms, living area, bedrooms. From floor to ceiling, whatever you need done, we can do it.',
                           background_picture: '/assets/blueprint1.jpg',
                           picture1: '/assets/Front.jpg',
                           picture2: '/assets/3.jpg',
                           picture3: '/assets/basement1.jpg' }.freeze

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
    if service == 'renovation'
      RENOVATION_SERVICE
    elsif service == 'carpentry'
      CARPENTRY_SERVICE
    elsif service == 'homes'
      HOME_BUILDING_SERVICE
    end
  end
end
