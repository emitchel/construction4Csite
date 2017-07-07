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
    @pictures = service[:pictures]
  end

  private

  SUPPORTED_SERVICES = %w[renovation carpentry homes].freeze

  RENOVATION_SERVICE = {title: 'Renovation Service',
                        subtitle: 'House Renovation',
                        description: 'Bathrooms, kitchens, bedrooms, entire basements, renovations are a great route for adding that personal touch',
                        background_picture: '/assets/bath1.jpg',
                        pictures: ['reno1.jpg', 'familytokitchen.jpg', 'reno2.jpg']}.freeze
  CARPENTRY_SERVICE = {title: 'Carpentry Service',
                       subtitle: 'Decks & Carpentry',
                       description: 'While we do specialize in customized decks, any type of carpentry isn\'t out of the question',
                       background_picture: '/assets/15.jpg',
                       pictures: ['5.jpg', 'goodeck.jpg', 'familyroom3.jpg']}.freeze
  HOME_BUILDING_SERVICE = {title: 'Home Building Service',
                           subtitle: 'Custom Home Building',
                           description: 'As far as custom home building we do everything. Custom kitchens, bathrooms, living area, bedrooms. From floor to ceiling, whatever you need done, we can do it.',
                           background_picture: '/assets/blueprint1.jpg',
                           pictures: %w[Front.jpg 3.jpg basement1.jpg 4.jpg 5.jpg 6.jpg 7.jpg 9.jpg b1.jpg b1p2.jpg b1p3.jpg b11.jpg b12.jpg bath1.jpg by1.jpg by2.jpg e.jpg e1.jpg e2.jpg f1.jpg f2.jpg familyroom1.jpg familyroom3.jpg familytokitchen.jpg fr2.jpg Front.jpg frontside1.jpg frontside2.jpg g2.jpg g3.jpg k2.jpg k5.jpg k6.jpg kitchen3.jpg kitchen4.jpg l1.jpg l2.jpg l3.jpg livingtoentry.jpg m1.jpg m2.jpg m3.jpg mb1.jpg mb2.jpg mb3.jpg mb4.jpg mbd1.jpg mbd2.jpg mbd3.jpg r1.jpg r2.jpg reno1.jpg reno2.jpg]}.freeze

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
